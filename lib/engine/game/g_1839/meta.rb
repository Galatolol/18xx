# frozen_string_literal: true

require_relative '../meta'

module Engine
  module Game
    module G1839
      module Meta
        include Game::Meta

        DEV_STAGE = :prealpha
        PROTOTYPE = true

        GAME_IMPLEMENTER = 'Jan Kłos based on 1839 by J C Lawrence'
        GAME_LOCATION = 'Netherlands'
        GAME_TITLE = '1839.Games'
        GAME_RULES_URL = 'https://kanga.nu/~claw/1839/1839-Rules.pdf'
        GAME_INFO_URL = ''

        PLAYER_RANGE = [2, 4].freeze
      end
    end
  end
end
