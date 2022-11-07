# frozen_string_literal: true

require_relative '../../../step/token'

module Engine
  module Game
    module G1839
      module Step
        class Token < Engine::Step::Token
          def can_place_token?(entity)
            current_entity == entity &&
              !@round.tokened &&
              !available_tokens(entity).empty?
          end

          def process_place_token(action)
            entity = action.entity
            city = action.city
            slot = action.slot
            token = action.token
            hex = city.hex
            tile = hex.tile

            if !@game.loading && !@game.graph.connected_nodes(entity)[city]
              city_string = hex.tile.cities.size > 1 ? " city #{city.index}" : ''
              raise GameError, "Cannot place token on #{hex.name}#{city_string} because it is not connected"
            end

            raise GameError, 'Token is already used' if token.used
            raise GameError, 'No token available to place' unless (new_token = entity.unplaced_tokens.first)

            if tile.cities.any? { |c| c.tokened_by?(entity) }
              raise GameError, "Cannot lay on #{hex.id}. Can only have one token per hex"
            end

            token.price = @game.calculate_token_cost(entity, city)
            old_token = city.tokens[slot]

            if old_token&.corporation&.id == 'NS'
              # Replace govt token

              old_token.remove!
              city.exchange_token(new_token)

              entity.spend(token.price, old_token.corporation)
              @game.log << "#{entity.name} replaces an NS token on #{hex.id} for #{@game.format_currency(token.price)}"

              @round.tokened = true
              @game.graph.clear
            else
              # Place new token
              super
            end
          end

          def can_replace_token?(_entity, token)
            return true unless token

            token.corporation.name == 'NS'
          end
        end
      end
    end
  end
end
