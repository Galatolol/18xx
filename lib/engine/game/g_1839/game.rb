# frozen_string_literal: true

require_relative 'meta'
require_relative '../base'
require_relative 'map'
require_relative 'entities'
require_relative '../stubs_are_restricted'

module Engine
  module Game
    module G1839
      class Game < Game::Base
        include_meta(G1839::Meta)
        include G1839::Map
        include G1839::Entities

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

        OFFBOARD_COLORS = [:red, :blue, :orange]
        RUHRGEBIED_HEXES = %w[J17 K18].freeze

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

        PHASES = [{ name: '2', train_limit: 4, tiles: [:yellow], operating_rounds: 1 },
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

        TRAINS = [{ name: '2', distance: 8, price: 80, rusts_on: '4', num: 6 },
                  { name: '3', distance: 3, price: 180, rusts_on: '6', num: 5 },
                  { name: '4', distance: 4, price: 300, rusts_on: 'D', num: 4 },
                  {
                    name: '5',
                    distance: 5,
                    price: 450,
                    num: 3,
                    events: [{ 'type' => 'close_companies' }],
                  },
                  { name: '6', distance: 6, price: 630, num: 2 },
                  {
                    name: 'D',
                    distance: 999,
                    price: 1100,
                    num: 20,
                    available_on: '6',
                    discount: { '4' => 300, '5' => 300, '6' => 300 },
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

        def revenue_for(route, stops)
          revenue = super
          revenue += ruhrgebied_value(route.corporation, stops)

          raise GameError, 'May not visit two offboards of the same color' if OFFBOARD_COLORS.include?(stops.first.tile.color) && stops.first.tile.color == stops.last.tile.color

          revenue
        end

        def ruhrgebied_value(corporation, stops)
          return 0 unless stops.any? { |s| RUHRGEBIED_HEXES.include?(s.hex.id) }
          revenues = []
          stops.each do |stop|
            revenue = get_current_revenue(stop.revenue)
            revenue *= 2 if OFFBOARD_COLORS.include?(stop.tile.color)
            revenues.append(revenue)
          end

          revenues.max
        end

        def get_current_revenue(revenue)
          phase.tiles.reverse_each { |color| return (revenue[color]) if revenue[color] }

          0
        end
      end
    end
  end
end
