# frozen_string_literal: true

module Engine
    module Game
      module G1839
        class Corporation < Engine::Corporation
          def initialize(sym:, name:, **opts)
            super

            @local = opts[:local]
          end

          def local?
            @local
          end
        end
      end
    end
  end