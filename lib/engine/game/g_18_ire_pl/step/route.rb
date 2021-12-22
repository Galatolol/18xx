# frozen_string_literal: true

require_relative '../../../step/route'

module Engine
  module Game
    module G18IrePL
      module Step
        class Route < Engine::Step::Route
          def process_run_routes(action)
            super

            bs = @company = @game.company_by_id('BS')&.id
            if action.entity.assigned?(bs)
              bs_hex_visits_count = 0
              action.routes.each do |route|
                route.visited_stops.each do |stop|
                  if stop.hex.assigned?(bs)
                    bs_hex_visits_count += 1
                    raise GameError, "#{action.entity.name} can't run to #{stop.hex.coordinates} more than once" if bs_hex_visits_count > 1
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
