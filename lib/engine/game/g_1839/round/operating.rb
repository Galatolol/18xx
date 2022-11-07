# frozen_string_literal: true

require_relative '../../../round/operating'

module Engine
  module Game
    module G1839
      module Round
        class Operating < Engine::Round::Operating

          def start_operating
            super

            return if finished?

            @game.update_govt_tokens_type(@current_operator)
          end
        end
      end
    end
  end
end
