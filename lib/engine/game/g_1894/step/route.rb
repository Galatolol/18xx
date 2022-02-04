# frozen_string_literal: true

require_relative '../../../step/route'

module Engine
  module Game
    module G1894
      module Step
        class Route < Engine::Step::Route
          def process_run_routes(action)
            super
            return if @game.loading

            if route_includes_england?(action.routes) && !@game.ferry_marker?(action.entity)
              raise GameError, 'Cannot run to England without a ferry marker'
            end
          end

          def route_includes_england?(routes)
            routes.flat_map(&:connection_hexes).flatten.include?(Engine::Game::G1894::Game::ENGLAND_HEX)
          end

          def route_uses_tile_lay(routes)
            stops = routes.first.visited_stops
            tile = @round.laid_hexes.first&.tile

            return !(stops & tile.nodes).empty? unless tile.nodes.empty?

            tile.paths.each do |path|
              path.walk { |p| return true unless (stops & p.nodes).empty? }
            end

            false
          end

          def available_hex(entity, hex)
            return @game.ferry_marker?(entity) if hex.id == Engine::Game::G1894::Game::ENGLAND_HEX

            super
          end
        end
      end
    end
  end
end
