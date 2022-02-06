# frozen_string_literal: true

require_relative '../../../step/token'

module Engine
  module Game
    module G18IrePL
      module Step
        class Token < Engine::Step::Token
          def available_hex(entity, hex)
            @game.graph.reachable_hexes(entity)[hex] &&
              hex.tile.color != :red
          end

          def place_token(entity, city, token)
            raise GameError, 'Cannot place token in an offboard location' if city.hex.tile.color == :red

            super(entity, city, token)
          end
        end
      end
    end
  end
end
