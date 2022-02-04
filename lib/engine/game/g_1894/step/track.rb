# frozen_string_literal: true

module Engine
  module Game
    module G1894
      module Step
        class Track < Engine::Step::Track
          def legal_tile_rotation?(_entity, _hex, tile)
            if _hex.id == 'G4' && _hex.tile.color == :green
              return true if tile.rotation == _hex.tile.rotation
            else
              super
            end
          end
        end
      end
    end
  end
end
