# frozen_string_literal: true

require_relative 'meta'
require_relative '../base'
require_relative 'stock_market'
require_relative 'map'
require_relative 'system'
require_relative 'shell'
require_relative '../cities_plus_towns_route_distance_str'

module Engine
  module Game
    module G1894
      class Game < Game::Base
        include_meta(G1894::Meta)
        include G1894::Map
        include CitiesPlusTownsRouteDistanceStr

        register_colors(hanBlue: '#446CCF',
                        steelBlue: '#4682B4',
                        brick: '#9C661F',
                        powderBlue: '#B0E0E6',
                        khaki: '#F0E68C',
                        darkGoldenrod: '#B8860B',
                        yellowGreen: '#9ACD32',
                        gray70: '#B3B3B3',
                        khakiDark: '#BDB76B',
                        thistle: '#D8BFD8',
                        lightCoral: '#F08080',
                        tan: '#D2B48C',
                        gray50: '#7F7F7F',
                        cinnabarGreen: '#61B329',
                        tomato: '#FF6347',
                        plum: '#DDA0DD',
                        lightGoldenrod: '#EEDD82')

        CURRENCY_FORMAT_STR = '$%d'

        BANK_CASH = 99_999

        CERT_LIMIT = { 3 => 99, 4 => 99, 5 => 99 }.freeze

        STARTING_CASH = { 3 => 800, 4 => 700, 5 => 620 }.freeze

        CAPITALIZATION = :full

        MUST_SELL_IN_BLOCKS = false

        MARKET = [
          %w[60
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
             255
             285
             325
             375
             425],
          %w[53o
             60
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
             225
             250
             275
             300
             330],
          %w[46o
             55o
             60
             65
             70
             76
             82p
             90
             100
             111
             125
             140
             155
             170
             190
             210],
          %w[39o
             48o
             54o
             60
             66
             71
             76p
             82
             90
             100
             110
             120
             130],
          %w[32o 41o 48o 55o 62 67 71p 76 82 90 100],
          %w[25o 34o 42o 50o 58o 65 67p 71 75 80],
          %w[18o 27o 36o 45o 54o 63 67 69 70],
          %w[10o 20o 30o 40o 50o 60 67 68],
          ['', '10o', '20o', '30o', '40o', '50o', '60'],
          ['', '', '10o', '20o', '30o', '40o', '50o'],
          ['', '', '', '10o', '20o', '30o', '40o'],
        ].freeze

        PHASES = [{ name: 'Yellow', train_limit: 4, tiles: [:yellow], operating_rounds: 1 },
                  {
                    name: 'Green',
                    on: '3',
                    train_limit: 4,
                    tiles: %i[yellow green],
                    operating_rounds: 2,
                    status: ['can_buy_companies'],
                  },
                  {
                    name: 'Blue',
                    on: '5',
                    train_limit: 4,
                    tiles: %i[yellow green],
                    operating_rounds: 2,
                    status: ['can_buy_companies'],
                  },
                  {
                    name: 'Brown',
                    on: '3+D',
                    train_limit: 3,
                    tiles: %i[yellow green brown],
                    operating_rounds: 3,
                    status: ['can_buy_companies'],
                  },
                  {
                    name: 'Red',
                    on: '6',
                    train_limit: 2,
                    tiles: %i[yellow green brown],
                    operating_rounds: 3,
                  },
                  {
                    name: 'Gray',
                    on: '8E',
                    train_limit: 2,
                    tiles: %i[yellow green brown],
                    operating_rounds: 3,
                  },
                  {
                    name: 'Purple',
                    on: 'D',
                    train_limit: 2,
                    tiles: %i[yellow green brown],
                    operating_rounds: 4,
                  }].freeze

        TRAINS = [{ name: '2', distance: 2, price: 80, rusts_on: '5', num: 7 },
                  {
                    name: '3',
                    distance: 3,
                    price: 160,
                    rusts_on: '6',
                    num: 9,
                    events: [{ 'type' => 'green_par' }],
                  },
                  {
                    name: '5',
                    distance: 5,
                    price: 250,
                    rusts_on: '8E',
                    num: 4,
                    events: [{ 'type' => 'blue_par' }],
                  },
                  {
                    name: '3+D',
                    distance: [{ 'nodes' => %w[city offboard], 'pay' => 3, 'visit' => 3, 'multiplier' => 2 },
                               {
                                 'nodes' => ['town'],
                                 'pay' => 99,
                                 'visit' => 99,
                                 'multiplier' => 2,
                               }],
                    price: 350,
                    rusts_on: 'D',
                    num: 6,
                    events: [{ 'type' => 'brown_par' }],
                  },
                  {
                    name: '6',
                    distance: 6,
                    price: 650,
                    num: 4,
                    events: [{ 'type' => 'close_companies' }],
                  },
                  {
                    name: '8E',
                    distance: [{ 'nodes' => %w[city offboard], 'pay' => 8, 'visit' => 8 },
                               { 'nodes' => ['town'], 'pay' => 0, 'visit' => 99 }],
                    price: 800,
                    num: 3,
                  },
                  {
                    name: 'D',
                    distance: 999,
                    price: 900,
                    num: 20,
                    events: [{ 'type' => 'remove_corporations' }],
                  }].freeze

        COMPANIES = [
          {
            name: 'Schuylkill Valley Navigation',
            value: 20,
            revenue: 5,
            desc: 'Blocks G19 while owned by a player.',
            sym: 'SVN',
            abilities: [{ type: 'blocks_hexes', owner_type: 'player', hexes: ['B1'] }],
            color: nil,
          },
          {
            name: 'Saint Clair Tunnel',
            value: 20,
            revenue: 5,
            desc: 'Blocks Sarnia (D10) while owned by a player. When this company is sold to a corporation, ' \
                  'revenue increases to $10.',
            sym: 'StCT',
            abilities: [{ type: 'blocks_hexes', owner_type: 'player', hexes: ['B1'] },
                        { type: 'revenue_change', revenue: 10, when: 'sold' }],
            color: nil,
          },
        ].freeze

        CORPORATIONS = [
          {
            sym: 'B&M',
            name: 'Boston & Maine',
            logo: '1828/BM',
            simple_logo: '1828/BM.alt',
            tokens: [0, 100, 100, 100],
            coordinates: 'B3',
            color: '#446CCF',
            abilities: [
            {
              type: 'description',
              description: 'Place a second yellow tile for $40',
            },
          ],
            reservation_color: nil,
          },
        ].freeze

        # MINORS = [
        #   {
        #     sym: 'C&P',
        #     name: 'Cobourg & Peterborough Railway',
        #     logo: '1828/CP',
        #     simple_logo: '1828/CP.alt',
        #     tokens: [0],
        #     coordinates: 'C15',
        #     color: '#7F7F7F',
        #   },
        # ].freeze

        LAYOUT = :pointy

        MULTIPLE_BUY_TYPES = %i[unlimited].freeze

        MUST_BID_INCREMENT_MULTIPLE = true
        MIN_BID_INCREMENT = 5

        HOME_TOKEN_TIMING = :operate

        TILE_RESERVATION_BLOCKS_OTHERS = true

        GAME_END_CHECK = {
          bankrupt: :immediate,
          stock_market: :current_round,
          final_phase: :one_more_full_or_set,
        }.freeze

        SELL_BUY_ORDER = :sell_buy_sell

        NEXT_SR_PLAYER_ORDER = :first_to_pass

        TRACK_RESTRICTION = :permissive

        DISCARDED_TRAINS = :remove

        MARKET_SHARE_LIMIT = 80 # percent

        MARKET_TEXT = Base::MARKET_TEXT.merge(par: 'Par',
                                              unlimited: 'Corporation shares can be held above 60% and ' \
                                                         'President may buy two shares at a time and ' \
                                                         'additional move up if sold out.')

        STOCKMARKET_COLORS = Base::STOCKMARKET_COLORS.merge(par: :red,
                                                            unlimited: :gray)

        EVENTS_TEXT = Base::EVENTS_TEXT.merge(
          'green_par' => ['Green phase pars',
                          '$86 and $94 par prices are now available'],
          'blue_par' => ['Blue phase pars',
                         '$105 par price is now available'],
          'brown_par' => ['Brown phase pars',
                          '$120 par price is now available'],
          'remove_corporations' => ['Unparred corporations removed',
                                    'All unparred corporations are removed at the beginning of next stock round.' \
                                    ' Blocking tokens placed in home stations.']
        ).freeze

        ENGLAND = 'A10'
        ENGLAND_FERRY_SUPPLY = 'A8'
        COAL_MARKER_ICON = 'coal'
        COAL_MARKER_COST = 120

        def new_auction_round
          Engine::Round::Auction.new(self, [
            G1894::Step::CompanyPendingPar,
            G1894::Step::WaterfallAuction,
          ])
        end

        def stock_round
          G1894::Round::Stock.new(self, [
            G1894::Step::DiscardTrain,
            G1894::Step::RemoveTokens,
            # G1894::Step::Merger,
            G1894::Step::Exchange,
            G1894::Step::BuySellParShares,
          ])
        end

        def operating_round(round_num)
          Engine::Round::Operating.new(self, [
            Engine::Step::Bankrupt,
            G1894::Step::Exchange,
            G1894::Step::DiscardTrain,
            Engine::Step::HomeToken,
            G1894::Step::BuyCompany,
            G1894::Step::SpecialTrack,
            G1894::Step::SpecialToken,
            G1894::Step::SpecialBuy,
            G1894::Step::Track,
            G1894::Step::Token,
            G1894::Step::Route,
            G1894::Step::Dividend,
            G1894::Step::SwapTrain,
            G1894::Step::BuyTrain,
            [Engine::Step::BuyCompany, { blocks: true }],
          ], round_num: round_num)
        end

        def setup
          # setup_minors
          setup_company_min_price

          @available_par_groups = %i[par]

          @log << "-- Setting game up for #{@players.size} players --"
          remove_extra_private_companies
          remove_extra_trains

          @coal_marker_ability =
            Engine::Ability::Description.new(type: 'description', description: 'Coal Marker')
          block_va_coalfields

          @blocking_corporation = Corporation.new(sym: 'B', name: 'Blocking', logo: '1828/blocking', tokens: [0])
        end

        def init_stock_market
          G1894::StockMarket.new(self.class::MARKET, [],
                                 multiple_buy_types: self.class::MULTIPLE_BUY_TYPES)
        end

        TILE_LAYS = [{ lay: true, upgrade: :not_if_upgraded, cannot_reuse_same_hex: true, cost: 0 }].freeze
        EXTRA_TILE_LAY_CORPS = %w[B&M NYH].freeze

        def tile_lays(entity)
          tile_lays = super
          tile_lays += [{ lay: true, upgrade: :not_if_upgraded, cannot_reuse_same_hex: true }] if entity.system?
          (entity.system? ? entity.corporations.map(&:name) : [entity.name]).each do |corp_name|
            next unless EXTRA_TILE_LAY_CORPS.include?(corp_name)

            tile_lays += [
              {
                lay: :not_if_upgraded,
                upgrade: false,
                cannot_reuse_same_hex: true,
                cost: 40,
              },
            ]
          end

          tile_lays
        end

        def can_hold_above_corp_limit?(_entity)
          true
        end

        def show_game_cert_limit?
          false
        end

        def init_round_finished
          @players.rotate!(@round.entity_index)

          @companies.each do |company|
            next unless company.owner

            abilities(company, :revenue_change, time: 'auction_end') do |ability|
              company.revenue = ability.revenue
            end
          end
        end

        # def event_green_par!
        #   @log << "-- Event: #{EVENTS_TEXT['green_par'][1]} --"
        #   @available_par_groups << :par_1
        #   update_cache(:share_prices)
        # end

        # def event_blue_par!
        #   @log << "-- Event: #{EVENTS_TEXT['blue_par'][1]} --"
        #   @available_par_groups << :par_2
        #   update_cache(:share_prices)
        # end

        # def event_brown_par!
        #   @log << "-- Event: #{EVENTS_TEXT['brown_par'][1]} --"
        #   @available_par_groups << :par_3
        #   update_cache(:share_prices)
        # end

        # def event_close_companies!
        #   super

        #   @minors.dup.each { |minor| remove_minor!(minor, block: true) }
        # end

        def event_remove_corporations!
          @log << "-- Event: #{EVENTS_TEXT['remove_corporations'][1]}. --"
          @log << 'Unparred corporations will be removed at the beginning of the next stock round'
        end

        def new_stock_round
          new_sr = super
          remove_unparred_corporations! if @phase.current[:name] == 'Purple'
          new_sr
        end

        def remove_unparred_corporations!
          @corporations.reject(&:ipoed).reject(&:closed?).each do |corporation|
            place_home_blocking_token(corporation)
            @log << "Removing #{corporation.name}"
            @corporations.delete(corporation)
          end
        end

        # def remove_minor!(minor, block: false)
        #   minor.spend(minor.cash, @bank) if minor.cash.positive?
        #   minor.tokens.each do |token|
        #     city = token&.city
        #     token.remove!
        #     place_blocking_token(city.hex) if block && city
        #   end
        #   @graph.clear_graph_for(minor)
        #   @minors.delete(minor)

        #   @round.force_next_entity! if @round.current_entity == minor
        # end

        # def upgrades_to?(from, to, _special = false, selected_company: nil)
        #   # Virginia tunnel can only be upgraded to #4 tile
        #   return false if from.hex.id == VA_TUNNEL_HEX && to.name != '4'

        #   super
        # end

        def par_prices
          @stock_market.share_prices_with_types(@available_par_groups)
        end

        def merge_candidates(player, corporation)
          return [] if corporation.system?

          @corporations.select { |candidate| merge_candidate?(player, corporation, candidate) }
        end

        def merge_candidate?(player, corporation, candidate)
          return false if candidate == corporation ||
                          candidate.system? ||
                          !candidate.ipoed ||
                          (corporation.owner != player && candidate.owner != player) ||
                          candidate.operated? != corporation.operated? ||
                          (!candidate.floated? && !corporation.floated?)

          # account for another player having 5+ shares
          @players.any? do |p|
            num_shares = p.num_shares_of(candidate) + p.num_shares_of(corporation)
            num_shares >= 6 ||
              (num_shares == 5 && !sold_this_round?(p, candidate) && !sold_this_round?(p, corporation))
          end
        end

        def sold_this_round?(entity, corporation)
          return false unless @round.players_sold

          @round.players_sold[entity][corporation]
        end

        def create_system(corporations)
          return nil unless corporations.size == 2

          system_data = CORPORATIONS.find { |c| c[:sym] == corporations.first.id }.dup
          system_data[:sym] = corporations.map(&:name).join('-')
          system_data[:tokens] = []
          system_data[:abilities] = []
          system_data[:corporations] = corporations
          system = init_system(@stock_market, system_data)

          @corporations << system
          @_corporations[system.id] = system
          system.shares.each { |share| @_shares[share.id] = share }

          corporations.each { |corporation| transfer_assets_to_system(corporation, system) }

          # Order tokens for better visual
          max_price = system.tokens.max_by(&:price).price + 1
          system.tokens.sort_by! { |t| (t.used ? -max_price : max_price) + t.price }

          place_system_blocking_tokens(system)

          # Make sure the system will not own two coal markers
          if coal_markers(system).size > 1
            remove_coal_marker(system)
            add_coal_marker_to_va_coalfields
            @log << "#{system.name} cannot have two coal markers, returning one to Virginia Coalfields"
          end

          @stock_market.set_par(system, system_market_price(corporations))
          system.ipoed = true

          system
        end

        def transfer_assets_to_system(corporation, system)
          corporation.spend(corporation.cash, system) if corporation.cash.positive?

          # Transfer tokens
          used, unused = corporation.tokens.partition(&:used)
          used.each do |t|
            new_token = Engine::Token.new(system, price: t.price)
            system.tokens << new_token
            t.swap!(new_token, check_tokenable: false)
          end
          unused.sort_by(&:price).each { |t| system.tokens << Engine::Token.new(system, price: t.price) }
          corporation.tokens.clear

          # Transfer companies
          corporation.companies.each do |company|
            company.owner = system
            system.companies << company
          end
          corporation.companies.clear

          # Transfer abilities
          corporation.all_abilities.dup.each do |ability|
            corporation.remove_ability(ability)
            system.add_ability(ability)
          end

          # Create shell and transfer
          shell = G1894::Shell.new(corporation.name, system)
          system.shells << shell
          corporation.trains.dup.each do |train|
            buy_train(system, train, :free)
            shell.trains << train
          end
        end

        def ipo_reserved_name(_entity = nil)
          'Treasury'
        end

        def coal_marker_available?
          hex_by_id(ENGLAND_FERRY_SUPPLY).tile.icons.any? { |icon| icon.name == COAL_MARKER_ICON }
        end

        def coal_marker?(entity)
          return false unless entity.corporation?

          coal_markers(entity).any?
        end

        def coal_markers(entity)
          entity.all_abilities.select { |ability| ability.description == @coal_marker_ability.description }
        end

        def connected_to_coalfields?(entity)
          graph.reachable_hexes(entity).include?(hex_by_id(ENGLAND))
        end

        def can_buy_coal_marker?(entity)
          return false unless entity.corporation?

          coal_marker_available? &&
            !coal_marker?(entity) &&
            buying_power(entity) >= COAL_MARKER_COST &&
            connected_to_coalfields?(entity)
        end

        def buy_coal_marker(entity)
          return unless can_buy_coal_marker?(entity)

          entity.spend(COAL_MARKER_COST, @bank)
          entity.add_ability(@coal_marker_ability.dup)
          @log << "#{entity.name} buys a coal marker for $#{COAL_MARKER_COST}"

          tile_icons = hex_by_id(ENGLAND_FERRY_SUPPLY).tile.icons
          tile_icons.delete_at(tile_icons.find_index { |icon| icon.name == COAL_MARKER_ICON })

          graph.clear
        end

        def acquire_va_tunnel_coal_marker(entity)
          entity = entity.owner if entity.company?

          @log << "#{entity.name} acquires a coal marker"
          if coal_marker?(entity)
            @log << "#{entity.name} already owns a coal marker, placing coal marker on Virginia Coalfields"
            add_coal_marker_to_va_coalfields
          else
            entity.add_ability(@coal_marker_ability.dup)
          end
        end

        def remove_coal_marker(entity)
          coal = entity.all_abilities.find { |ability| ability.description == @coal_marker_ability.description }
          entity.remove_ability(coal)
        end

        def add_coal_marker_to_va_coalfields
          hex_by_id(ENGLAND_FERRY_SUPPLY).tile.icons << Engine::Part::Icon.new('1828/coal', 'coal')
        end

        def block_va_coalfields
          coalfields = hex_by_id(ENGLAND).tile.cities.first

          coalfields.instance_variable_set(:@game, self)

          def coalfields.blocks?(corporation)
            !@game.coal_marker?(corporation)
          end
        end

        def can_run_route?(entity)
          return false if entity.id == 'C&P' && @round.laid_hexes.empty?

          super
        end

        def city_tokened_by?(city, entity)
          return @graph.connected_nodes(entity)[city] if entity.id == 'C&P'

          super
        end

        def place_home_token(corporation)
          if corporation.system? && !corporation.tokens.first&.used
            corporation.corporations.each do |c|
              token = Engine::Token.new(c)
              c.tokens << token
              place_home_token(c)

              system_token = corporation.tokens.find do |t|
                t.price.zero? && !t.used && !@round.pending_tokens.find { |p_t| p_t[:token] == t }
              end
              if (pending_token = @round.pending_tokens.find { |p_t| p_t[:entity] == c })
                pending_token[:entity] = corporation
                pending_token[:token] = system_token
                pending_token[:hexes].first.tile.reservations.map! { |r| r == c ? corporation : r }
              else
                token.swap!(system_token, check_tokenable: false)
              end
            end
          else
            super
          end
        end

        def place_blocking_token(hex, city: nil)
          @log << "Placing a blocking token on #{hex.name} (#{hex.location_name})"
          token = Token.new(@blocking_corporation)
          city ||= hex.tile.cities[0]
          city.place_token(@blocking_corporation, token, check_tokenable: false)
        end

        def blocking_token?(token)
          token&.corporation == @blocking_corporation
        end

        def exchange_for_partial_presidency?
          true
        end

        def exchange_partial_percent(share)
          return nil unless share.president

          100 / share.num_shares
        end

        def system_by_id(id)
          corporation_by_id(id)
        end

        def close_companies_on_event!(entity, event)
          return unless event == 'bought_train'

          if entity.system?
            entity.corporations.each { |c| super(c, event) }
          else
            super
          end
        end

        def remove_train(train)
          super

          train.owner.remove_train(train) if train.owner&.system?
        end

        def hex_blocked_by_ability?(entity, _ability, hex)
          return false if entity.name == 'C&P' && hex.id == 'C15'

          super
        end

        def purchasable_companies(entity = nil)
          return [] if entity&.minor?

          super
        end

        private

        # def setup_minors
        #   @minors.each do |minor|
        #     train = @depot.upcoming[1]
        #     train.buyable = false
        #     train.rusts_on = nil
        #     buy_train(minor, train, :free)
        #     @depot.forget_train(train)
        #     hex = hex_by_id(minor.coordinates)
        #     hex.tile.cities[0].place_token(minor, minor.next_token, free: true)
        #   end
        # end

        def setup_company_min_price
          @companies.each { |company| company.min_price = 1 }
        end

        def privates_to_remove
          ok = false
          until ok
            to_remove = companies.find_all { |company| company.value == 250 }
                                 .sort_by { rand }
                                 .take(7 - @players.size)
            if @optional_rules&.include?(:ensure_good_privates)
              removed_syms = to_remove.map(&:sym)
              ok = !%w[GT NW OSH].all? { |sym| removed_syms.include?(sym) }
            else
              ok = true
            end
          end
          to_remove
        end

        def remove_extra_private_companies
          to_remove = privates_to_remove
          to_remove.each do |company|
            company.close!
            @round.steps.find { |step| step.is_a?(G1894::Step::WaterfallAuction) }.companies.delete(company)
            @log << "Removing #{company.name}"
          end
        end

        def remove_extra_trains
          return unless @players.size < 5

          to_remove = @depot.trains.reverse.find { |train| train.name == '6' }
          @depot.forget_train(to_remove)
          @log << "Removing #{to_remove.name} train"
        end

        def place_home_blocking_token(corporation)
          cities = []

          hex = hex_by_id(corporation.coordinates)
          if hex.tile.reserved_by?(corporation)
            cities.concat(hex.tile.cities)
          else
            cities << hex.tile.cities.find { |city| city.reserved_by?(corporation) }
            cities.first.remove_reservation!(corporation)
          end

          cities.each { |city| place_blocking_token(hex, city: city) }
        end

        # def init_system(stock_market, system)
        #   G1894::System.new(
        #     min_price: stock_market.par_prices.map(&:price).min,
        #     capitalization: self.class::CAPITALIZATION,
        #     **system.merge(corporation_opts),
        #   )
        # end

        # def place_system_blocking_tokens(system)
        #   system.tokens.select(&:used).group_by(&:city).each do |city, tokens|
        #     next unless tokens.size > 1

        #     tokens[1].remove!
        #     place_blocking_token(city.hex)
        #   end
        # end

        # def system_market_price(corporations)
        #   market = @stock_market.market
        #   share_prices = corporations.map(&:share_price)
        #   share_values = share_prices.map(&:price).sort

        #   left_most_col = share_prices.min { |a, b| a.coordinates[1] <=> b.coordinates[1] }.coordinates[1]
        #   max_share_value = share_values[1] + (share_values[0] / 2).floor

        #   new_market_price = nil
        #   if market[0][left_most_col].price < max_share_value
        #     i = market[0].size - 1
        #     i -= 1 while market[0][i].price > max_share_value
        #     new_market_price = market[0][i]
        #   else
        #     i = 0
        #     i += 1 while market[i][left_most_col].price > max_share_value
        #     new_market_price = market[i][left_most_col]
        #   end

        #   new_market_price
        # end
      end
    end
  end
end
