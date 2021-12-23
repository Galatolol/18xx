# frozen_string_literal: true

require_relative 'meta'
require_relative 'entities'
require_relative 'map'

module Engine
  module Game
    module G18IrePL
      class Game < Game::Base
        include_meta(G18IrePL::Meta)
        include G18IrePL::Entities
        include G18IrePL::Map
        include CitiesPlusTownsRouteDistanceStr

        CAPITALIZATION = :incremental
        HOME_TOKEN_TIMING = :par
        SELL_BUY_ORDER = :sell_buy
        MUST_BUY_TRAIN = :always
        EBUY_SELL_MORE_THAN_NEEDED_LIMITS_DEPOT_TRAIN = true
        EBUY_OTHER_VALUE = false
        CERT_LIMIT_COUNTS_BANKRUPTED = true
        TRACK_RESTRICTION = :permissive
        DISCARDED_TRAINS = :remove
        MUST_BID_INCREMENT_MULTIPLE = true
        MIN_BID_INCREMENT = 5

        MARKET_TEXT = Base::MARKET_TEXT.merge(par: 'Yellow Phase Par',
                                              par_1: 'Green Phase Par',
                                              par_3: 'Brown Phase Par',)

        STOCKMARKET_COLORS = Base::STOCKMARKET_COLORS.merge(par: :orange,
                                                            par_1: :green,
                                                            par_3: :brown,
                                                            endgame: :red)

        ASSIGNMENT_TOKENS = {
          'IOL' => '/icons/18_ire_pl/iol_token.svg',
          'BS' => '/icons/18_ire_pl/bs_token.svg',
        }.freeze

        IOL_HEX_COORDINATES = 'F12'

        CURRENCY_FORMAT_STR = '%d zł'
        BANK_CASH = 4000
        CERT_LIMIT = { 3 => 16, 4 => 12, 5 => 10, 6 => 8 }.freeze
        STARTING_CASH = { 3 => 400, 4 => 300, 5 => 240, 6 => 210 }.freeze
        LIMIT_TOKENS_AFTER_MERGER = 4
        GAME_END_CHECK = { bankrupt: :full_or, stock_market: :full_or, bank: :full_or }.freeze

        MARKET = [
          ['', '62', '68', '76', '84', '92', '100p', '110', '122x', '134', '148w', '170', '196', '225', '260e'],
          ['', '58', '64', '70', '78', '85p', '94', '102', '112', '124', '136', '150', '172', '198'],
          ['', '55', '60', '65', '70p', '78', '86', '95', '104', '114', '125', '138'],
          ['', '50y', '55', '60p', '66', '72', '80', '88', '96', '106', '116'],
          ['', '38y', '50p', '55', '60', '66', '72', '80', '89', '97'],
          ['', '30y', '38y', '50y', '55y', '60', '67', '74', '82'],
          ['', '24y', '30y', '38y', '50y', '55y'],
          %w[0c 20y 24y 30y 38y 50y],
        ].freeze

        PHASES = [
          {
            name: 'Yellow',
            train_limit: 2,
            tiles: [:yellow],
            operating_rounds: 2,
          },
          {
            name: 'Green',
            on: '3',
            train_limit: { minor: 2, major: 4 },
            tiles: %i[yellow green],
            operating_rounds: 2,
            status: ['can_buy_companies'],
          },
          {
            name: 'Blue',
            on: '3+',
            train_limit: { minor: 2, major: 3 },
            tiles: %i[yellow green],
            operating_rounds: 2,
            status: ['can_buy_companies'],
          },
          {
            name: 'Brown',
            on: '4',
            train_limit: { minor: 2, major: 3 },
            tiles: %i[yellow green brown],
            operating_rounds: 2,
          },
          {
            name: 'Red',
            on: '4+',
            train_limit: { minor: 1, major: 2 },
            tiles: %i[yellow green brown],
            operating_rounds: 2,
          },
          {
            name: 'Gray',
            on: '4D',
            train_limit: { minor: 1, major: 2 },
            tiles: %i[yellow green brown],
            operating_rounds: 2,
          },
        ].freeze

        TRAINS = [
          {
            name: '2',
            num: 6,
            distance: 2,
            price: 80,
            rusts_on: '3+',
          },
          {
            name: '3',
            num: 5,
            distance: 3,
            price: 180,
            rusts_on: '4+',
            events: [{ 'type' => 'corporations_can_merge' },
                     { 'type' => 'green_par' }],
          },
          {
            name: '3+',
            num: 4,
            distance: [{ 'nodes' => %w[city offboard], 'pay' => 3, 'visit' => 3 },
                       { 'nodes' => ['town'], 'pay' => 99, 'visit' => 99 }],
            price: 280,
            rusts_on: '4D',
          },
          {
            name: '4',
            num: 3,
            distance: 4,
            price: 360,
            events: [{ 'type' => 'iol_must_be_assigned' },
                     { 'type' => 'close_companies' },
                     { 'type' => 'brown_par' }],
          },
          {
            name: '4+',
            num: 2,
            distance: [{ 'nodes' => %w[city offboard], 'pay' => 4, 'visit' => 4 },
                       { 'nodes' => ['town'], 'pay' => 99, 'visit' => 99 }],
            price: 480,
          },
          {
            name: '4D',
            num: 20,
            distance: [{ 'nodes' => %w[city offboard town], 'pay' => 4, 'visit' => 4, 'multiplier' => 2 }],
            price: 720,
            events: [{ 'type' => 'train_trade_allowed' }],
            discount: {
              "3+" => 440,
              '4' => 360,
              '4+' => 240,
            },
          },
        ].freeze

        EVENTS_TEXT = Base::EVENTS_TEXT.merge('corporations_can_merge' => ['Corporations can merge',
                                                                           'Players can vote to merge corporations'],
                                              'green_par' => ['Green phase pars',
                                                              '122zł par price is now available'],
                                              'brown_par' => ['Brown phase pars',
                                                              '148zł par price is now available'],
                                              'train_trade_allowed' => ['Train trade in allowed',
                                                                        'Trains can be traded in for face value for more powerful trains'],).freeze

        MINOR_A_ID = 'MA'
        MINOR_B_ID = 'MB'
        # Corporation guaranteed to be in the game
        PROTECTED_CORPORATION = 'M8'

        def iol_company
          company_by_id('IOL')
        end

        def bs_company
          company_by_id('BS')
        end

        def revenue_for(route, stops)
          revenue = super

          #+10 bonus
          revenue += 10 if (stops.map(&:hex).find { |hex| hex.coordinates == @plus_ten_hex_coordinates })

          # Bonus for assignments
          iol = iol_company&.id
          revenue += 20 if (stops.map(&:hex).find { |hex| hex.assigned?(iol) })
          bs = bs_company&.id
          revenue += 40 if route.corporation.assigned?(bs) && (stops.map(&:hex).find { |hex| hex.assigned?(bs) })

          if route.train.owner.companies.include?(company_by_id('BS'))
            bs_hex_visits_count = 0
            route.routes.each do |route|
              route.visited_stops.each do |stop|
                if stop.hex.assigned?(bs)
                  bs_hex_visits_count += 1
                  raise GameError, "#{route.train.owner.name} can't run to #{stop.hex.coordinates} more than once" if bs_hex_visits_count > 1
                end
              end
            end
          end

          revenue
        end

        def unstarted_corporation_summary
          unipoed = @corporations.reject(&:ipoed)
          minor, major = unipoed.partition { |c| c.type == :minor }
          ["#{major.size} major", minor]
        end

        def timeline
          timeline = []
          minors = @corporations.select { |c| !c.ipoed && c.type == :minor }.map(&:name)
          timeline << "Minors: #{minors.join(', ')}" unless minors.empty?
          timeline
        end

        def sorted_corporations
          # Corporations sorted by some potential game rules
          ipoed, others = corporations.partition(&:ipoed)
          ipoed.sort + others
        end

        def remove_corporation(corporations)
          removed_corporation = corporations.first
          @log << "Removed #{removed_corporation.id} corporation"
          close_corporation(removed_corporation)
          corporations.delete(removed_corporation)
        end

        SOUTHERN_OFFBOARDS = %w[A13 C17 I19 K17]
        NORTHERN_OFFBOARDS = %w[G3 I3 K5]
        POTENTIAL_PLUS_TEN_HEXES = %w[C9 C13 E3 F16 G17]

        def optional_hexes
          hexes = G18IrePL::Map::HEXES

          southern_offboards_randomized = SOUTHERN_OFFBOARDS.sort_by { rand }
          @minor_A_starting_location = southern_offboards_randomized.shift

          northern_offboards_randomized = NORTHERN_OFFBOARDS.sort_by { rand }
          @minor_B_starting_location = northern_offboards_randomized.shift

          empty_gray_hexes = southern_offboards_randomized + northern_offboards_randomized

          new_hexes = {}
          HEXES.keys.each do |color|
            new_map = self.class::HEXES[color].transform_keys do |coords|
              coords - empty_gray_hexes
            end
            empty_gray_hexes_dict = empty_gray_hexes.to_h { |h| [[h], ''] }
            empty_gray_hexes_dict.each { |coords, tile_str| new_map[coords] = tile_str } if color == :gray

            new_hexes[color] = new_map
          end

          new_hexes
        end

        def setup
          @available_par_groups = %i[par]

          corporations, @future_corporations = @corporations.partition do |corporation|
            corporation.type == :minor
          end

          minor_A = corporations.find { |c| c.id == MINOR_A_ID }
          minor_A.coordinates = @minor_A_starting_location
          hex_by_id(minor_A.coordinates).tile.add_reservation!(minor_A, 0)
          minor_B = corporations.find { |c| c.id == MINOR_B_ID }
          minor_B.coordinates = @minor_B_starting_location
          hex_by_id(minor_B.coordinates).tile.add_reservation!(minor_B, 0)
          @log << "Offboards in play: #{@minor_A_starting_location} and #{@minor_B_starting_location}"

          potential_plus_ten_hexes_randomized = POTENTIAL_PLUS_TEN_HEXES.sort_by { rand }
          @plus_ten_hex_coordinates = potential_plus_ten_hexes_randomized.shift
          plus_ten_hex = hex_by_id(@plus_ten_hex_coordinates)
          plus_ten_hex.tile.icons << Part::Icon.new('/18_ire_pl/plus_ten_token')
          @log << "+10 marker placed in #{@plus_ten_hex_coordinates}"

          protect = corporations.find { |c| c.id == PROTECTED_CORPORATION }
          corporations.delete(protect)
          corporations.sort_by! { rand }
          remove_corporation(corporations)
          remove_corporation(corporations)
          corporations.unshift(protect)

          @corporations = corporations
        end

        def close_corporation(corporation, quiet: false)
          # Share holders gain the final value of shares on corporations from bankrupt players
          if corporation.share_price&.price&.positive? && corporation.owner&.bankrupt
            payouts = {}
            per_share = corporation.share_price.price
            @players.each do |holder|
              next if holder.bankrupt

              amount = holder.num_shares_of(corporation, ceil: false) * per_share
              next unless amount.positive?

              payouts[holder] = amount
              @bank.spend(amount, holder)
            end
            receivers = payouts
            .sort_by { |_r, c| -c }
            .map { |receiver, cash| "#{format_currency(cash)} to #{receiver.name}" }.join(', ')

            @log << "Bank settles for #{corporation.name} #{format_currency(per_share)} per share = #{receivers}"
          end

          super
          corporation.close!
        end

        def get_par_prices(entity, _corp)
          @game
            .stock_market
            .par_prices
            .select { |p| p.price * 2 <= entity.cash }
        end

        def after_buy_company(player, company, price)
          abilities(company, :shares) do |ability|
            ability.shares.each do |share|
              if share.president
                # M8 is pared at the highest par price below
                corporation = share.corporation
                par_price = price / 2
                share_price = @stock_market.par_prices.find { |sp| sp.price <= [100, par_price].min }

                @stock_market.set_par(corporation, share_price)
                @share_pool.buy_shares(player, share, exchange: :free)

                after_par(corporation)

                # Clear the corporation of money
                corporation.spend(corporation.cash, @bank)
                # Receives the bid money
                @bank.spend(price, corporation)
              else
                share_pool.buy_shares(player, share, exchange: :free)
              end
            end
          end
        end

        def home_token_locations(corporation)
          hexes.select do |hex|
            !hex.tile.exits.empty? && hex.tile.cities.any? { |city| city.tokenable?(corporation, free: true) }
          end
        end

        def buying_power(entity, **)
          # Cannot issue shares to buy trains
          entity.cash
        end

        def issuable_shares(entity)
          return [] unless entity.corporation?
          return [] unless entity.num_ipo_shares

          # Can only issue 1
          bundles_for_corporation(entity, entity)
            .select { |bundle| @share_pool.fit_in_bank?(bundle) }.take(1)
        end

        def redeemable_shares(entity)
          return [] unless entity.corporation?

          # Can only redeem 1
          bundles_for_corporation(@share_pool, entity).reject { |bundle| entity.cash < bundle.price }.take(1)
        end

        def par_prices
          @stock_market.share_prices_with_types(@available_par_groups)
        end

        def stock_round
          G18IrePL::Round::Stock.new(self, [
            Engine::Step::DiscardTrain,
            Engine::Step::Exchange,
            Engine::Step::HomeToken,
            G18IrePL::Step::BuySellParShares,
          ])
        end

        def merger_round
          G18IrePL::Round::Merger.new(self, [
            Engine::Step::DiscardTrain,
            G18IrePL::Step::MergerVote,
            G18IrePL::Step::Merge,
          ], round_num: @round.round_num)
        end

        def operating_round(round_num)
          Engine::Round::Operating.new(self, [
            G18IrePL::Step::Bankrupt,
            Engine::Step::Exchange,
            G18IrePL::Step::SpecialTrack,
            Engine::Step::HomeToken,
            Engine::Step::BuyCompany,
            Engine::Step::Assign,
            G18IrePL::Step::IssueShares,
            Engine::Step::Track,
            G18IrePL::Step::Token,
            Engine::Step::Route,
            G18IrePL::Step::Dividend,
            Engine::Step::DiscardTrain,
            G18IrePL::Step::BuyTrain,
            [Engine::Step::BuyCompany, { blocks: true }],
          ], round_num: round_num)
        end

        def new_or!
          if @round.round_num < @operating_rounds
            new_operating_round(@round.round_num + 1)
          else
            @turn += 1
            or_set_finished
            new_stock_round
          end
        end

        def next_round!
          @round =
            case @round
            when Engine::Round::Stock
              @operating_rounds = @final_operating_rounds || @phase.operating_rounds
              reorder_players
              new_operating_round
            when Engine::Round::Operating
              or_round_finished
              if @round.round_num < @operating_rounds || phase.name.to_i == 2
                new_or!
              else
                @log << "-- #{round_description('Merger', @round.round_num)} --"
                merger_round
              end
            when G18IrePL::Round::Merger
              new_or!
            when init_round.class
              reorder_players
              new_stock_round
            end
        end

        def event_corporations_can_merge!
          # minors can now merge to majors
          @corporations.concat(@future_corporations)
          @future_corporations = []
        end

        def event_green_par!
          @log << "-- Event: #{EVENTS_TEXT['green_par'][1]} --"
          @available_par_groups << :par_1
          update_cache(:share_prices)
        end

        def event_brown_par!
          @log << "-- Event: #{EVENTS_TEXT['brown_par'][1]} --"
          @available_par_groups << :par_3
          update_cache(:share_prices)
        end

        def event_iol_must_be_assigned!
          iol_hex = hexes.find { |hex| hex.coordinates == IOL_HEX_COORDINATES }
          iol = iol_company&.id
          unless iol_hex.assigned?(iol)
            iol_hex.assign!(iol)
            @log << "-- Event: +20 marker placed in #{IOL_HEX_COORDINATES} --"
          end
        end

        def event_train_trade_allowed!; end
      end
    end
  end
end
