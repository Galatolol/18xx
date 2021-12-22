# frozen_string_literal: true

require_relative '../../../step/special_track'
require_relative '../../../step/track_lay_when_company_sold'

module Engine
  module Game
    module G18IrePL
      module Step
        class SpecialTrack < Engine::Step::SpecialTrack
          include Engine::Step::TrackLayWhenCompanySold
        end
      end
    end
  end
end