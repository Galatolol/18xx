# frozen_string_literal: true

require_relative 'meta'
require_relative '../base'
require_relative 'map'
require_relative 'entities'
require_relative 'corporation'
require_relative '../stubs_are_restricted'
require_relative '../cities_plus_towns_route_distance_str'

module Engine
  module Game
    module G1839
      class Game < Game::Base
        include_meta(G1839::Meta)
        include G1839::Map
        include G1839::Entities
        include CitiesPlusTownsRouteDistanceStr
        include StubsAreRestricted

        register_colors(red: '#d1232a',
                        orange: '#f58121',
                        black: '#110a0c',
                        blue: '#025aaa',
                        lightBlue: '#8dd7f6',
                        yellow: '#ffe600',
                        green: '#32763f',
                        brightGreen: '#6ec037')
        TRACK_RESTRICTION = :permissive
        SELL_BUY_ORDER = :sell_buy_sell
        TILE_RESERVATION_BLOCKS_OTHERS = true
        CURRENCY_FORMAT_STR = 'ƒ%s'

        BANK_CASH = 99_999

        CERT_LIMIT = { 2 => 28, 3 => 20, 4 => 16 }.freeze

        STARTING_CASH = { 2 => 740, 3 => 660, 4 => 580 }.freeze

        OFFBOARD_COLORS = %i[red blue orange]
        RUHRGEBIED_HEXES = %w[J17 K18].freeze

        TILE_LAYS = [
          { lay: true, upgrade: true },
          { lay: true, upgrade: :not_if_upgraded, cost: 20, cannot_reuse_same_hex: true },
        ].freeze

        MARKET = [
          %w[60y
             67
             71
             76
             82
             90
             100p
             112
             126
             142
             160
             180
             200
             225
             250
             275
             300
             325
             350],
          %w[53y
             60y
             66
             70
             76
             82
             90p
             100
             112
             126
             142
             160
             180
             200
             220
             240
             260
             280
             300],
        ].freeze

        PHASES = [{ name: '2', train_limit: 4, tiles: [:yellow, :green], operating_rounds: 1 },
                  {
                    name: '3',
                    on: '3',
                    train_limit: 4,
                    tiles: %i[yellow green],
                    operating_rounds: 2,
                    status: ['can_buy_companies'],
                  },
                  {
                    name: '4',
                    on: '4',
                    train_limit: 3,
                    tiles: %i[yellow green],
                    operating_rounds: 2,
                    status: ['can_buy_companies'],
                  },
                  {
                    name: '5',
                    on: '5',
                    train_limit: 2,
                    tiles: %i[yellow green brown],
                    operating_rounds: 3,
                  },
                  {
                    name: '6',
                    on: '6',
                    train_limit: 2,
                    tiles: %i[yellow green brown],
                    operating_rounds: 3,
                  },
                  {
                    name: 'D',
                    on: 'D',
                    train_limit: 2,
                    tiles: %i[yellow green brown],
                    operating_rounds: 3,
                  }].freeze

        TRAINS = [{
                    name: 'PR5+_exp',
                    distance: [{ 'nodes' => %w[city offboard], 'pay' => 5, 'visit' => 5 },
                               { 'nodes' => ['town'], 'pay' => 99, 'visit' => 99 }],
                    price: 280,
                    num: 7,
                  },
                  { name: '2', distance: 8, price: 80, rusts_on: '4', num: 6 },
                  {
                    name: '3+',
                    distance: [{ 'nodes' => %w[city offboard], 'pay' => 3, 'visit' => 3 },
                               { 'nodes' => ['town'], 'pay' => 99, 'visit' => 99 }],
                    price: 160,
                    rusts_on: 'R4',
                    num: 9
                  },
                  {
                    name: '4+',
                    distance: [{ 'nodes' => %w[city offboard], 'pay' => 4, 'visit' => 4 },
                               { 'nodes' => ['town'], 'pay' => 99, 'visit' => 99 }],
                    price: 240,
                    rusts_on: 'PR2+',
                    num: 7
                  },
                  {
                    name: 'R4',
                    distance: 4,
                    price: 320,
                    rusts_on: '4',
                    num: 7,
                  },
                  {
                    name: 'PR2+',
                    distance: [{ 'nodes' => %w[city offboard], 'pay' => 2, 'visit' => 2 },
                    { 'nodes' => ['town'], 'pay' => 99, 'visit' => 99 }],
                    price: 280,
                    num: 7,
                  },
                  {
                    name: '4',
                    distance: 4,
                    price: 460,
                    num: 5,
                  },
                  {
                    name: 'D',
                    distance: 999,
                    price: 570,
                    rusts_on: 'D',
                    num: 40,
                  }].freeze

        LAYOUT = :pointy

        def operating_round(round_num)
          Round::Operating.new(self, [
            Engine::Step::Bankrupt,
            Engine::Step::Exchange,
            Engine::Step::SpecialTrack,
            Engine::Step::SpecialToken,
            Engine::Step::BuyCompany,
            Engine::Step::HomeToken,
            Engine::Step::Track,
            Engine::Step::Token,
            Engine::Step::Route,
            Engine::Step::Dividend,
            Engine::Step::DiscardTrain,
            Engine::Step::BuyTrain,
            [Engine::Step::BuyCompany, { blocks: true }],
          ], round_num: round_num)
        end

        def setup
          @govt_corporation = Corporation.new(sym: 'NS', name: 'Government', logo: '1882/neutral', tokens: [])
        end

        def place_govt_token(hex, city: nil)
          @log << "Placing a government token on #{hex.name} (#{hex.location_name})"
          token = Token.new(@govt_corporation)
          @govt_corporation.tokens << token
          city ||= hex.tile.cities[0]
          city.place_token(@govt_corporation, token, check_tokenable: false)
        end

        def init_corporations(stock_market)
          corporations = self.class::CORPORATIONS.map do |corporation|
            G1839::Corporation.new(
              min_price: stock_market.par_prices.map(&:price).min,
              capitalization: self.class::CAPITALIZATION,
              **corporation.merge(corporation_opts),
            )
          end

          corporations
        end

        # For local corporations treat govt tokens as neutral
        def update_govt_tokens_type(entity)
          new_type = entity.corporation.local? ? :neutral : :normal
          @govt_corporation.tokens.each { |t| t.type = new_type }
        end

        def check_distance(route, visits)
          super

          stops = route.stops

          raise GameError, 'Trains may not visit two offboards of the same color' if is_stop_offboard?(stops.first) && stops.first.tile.color == stops.last.tile.color

          #raise GameError, 'Local corporations may not visit offboards' if route.corporation.local? && (is_stop_offboard?(stops.first) || is_stop_offboard?(stops.last))

          raise GameError, 'P trains may visit only one offboard' if route.train.name.include?('P') && is_stop_offboard?(stops.first) && is_stop_offboard?(stops.last)
        end

        def stop_on_other_route?(this_route, stop, train)
          this_route.routes.each do |r|
            return false if r == this_route

            other_stops = r.stops

            return true if other_stops.include?(stop)
            return true unless (other_stops.flat_map(&:groups) & stop.groups).empty?
          end

          false
        end

        def revenue_for(route, stops)
          revenue = super
          revenue += ruhrgebied_value(route.corporation, stops)

          revenue
        end

        def revenue_for(route, stops)
          return stops.sum { |s| stop_or_ruhrgebied_revenue(s, stops) } if route.train.name.include?('R')

          stops.sum do |stop|
            stop_on_other_route?(route, stop) ? 0 : stop_or_ruhrgebied_revenue(stop, stops)
          end
        end

        def stop_or_ruhrgebied_revenue(stop, stops)
          return ruhrgebied_revenue(stops) if RUHRGEBIED_HEXES.include?(stop.hex.id)

          stop_revenue(stop.revenue)
        end

        def ruhrgebied_revenue(stops)
          revenues = []
          stops.each do |stop|
            revenue = stop_revenue(stop.revenue)
            revenue *= 2 if OFFBOARD_COLORS.include?(stop.tile.color)
            revenues.append(revenue)
          end

          revenues.max
        end

        def stop_revenue(revenue)
          phase.tiles.reverse_each { |color| return (revenue[color]) if revenue[color] }
        end

        def is_stop_offboard?(stop)
          OFFBOARD_COLORS.include?(stop.tile.color)
        end

        def rust(train)
          if train.name.include?('R') && !train.ever_operated
            train.obsolete = true
            return
          end

          super
        end
      end
    end
  end
end
