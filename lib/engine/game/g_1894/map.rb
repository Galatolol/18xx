# frozen_string_literal: true

module Engine
  module Game
    module G1894
      module Map
        TILES = {
        '1' => 1,
        '2' => 1,
        '3' => 3,
        '4' => 4,
        '7' => 6,
        '8' => 16,
        '9' => 16,
        '14' => 6,
        '15' => 4,
        '16' => 1,
        '17' => 1,
        '18' => 1,
        '19' => 1,
        '20' => 1,
        '23' => 4,
        '24' => 4,
        '25' => 3,
        '26' => 2,
        '27' => 2,
        '28' => 2,
        '29' => 2,
        '30' => 2,
        '31' => 2,
        '39' => 2,
        '40' => 2,
        '41' => 2,
        '42' => 2,
        '43' => 2,
        '44' => 2,
        '45' => 2,
        '46' => 2,
        '47' => 2,
        '53' => 1,
        '54' => 1,
        '55' => 1,
        '56' => 1,
        '57' => 8,
        '58' => 3,
        '59' => 3,
        '61' => 1,
        '62' => 1,
        '63' => 3,
        '64' => 1,
        '65' => 1,
        '66' => 1,
        '67' => 1,
        '68' => 1,
        '69' => 1,
        '70' => 2,
        '121' => 1,
        '205' => 1,
        '206' => 1,
        '448' => 2,
        '449' => 2,
        '997' => 1,
        }.freeze

              LOCATION_NAMES = {
                'A2' => 'Ireland',
                'A10' => 'England',
                'B3' => 'Le Havre',
                'B9' => 'Calais',
                'B11' => 'Dunkerque',
                'C18' => 'Netherlands',
              }.freeze

              HEXES = {
                white: {
                  %w[C4
                     D7
                     D9
                     D13
                     E2
                     E8
                     E14
                     E18
                     F1
                     F3
                     F7
                     F9
                     F17
                     G8
                     H1
                     H3
                     H11
                     I4
                     I10
                     I12] => '',
                  %w[B1 B7 C2 C8 C10 C14 D5 E4 F13 G6 H5 H9 H15] => 'upgrade=cost:60,terrain:water',
                  %w[B3 B9 B11 D3 D15 E6 E10 E16 G10 G14 H17] => 'city=revenue:0',
                  ['B13'] => 'border=edge:5,type:mountain',
                  ['C12'] => 'border=edge:4,type:mountain;border=edge:5,type:mountain',
                  ['D11'] => 'city=revenue:0;border=edge:4,type:mountain',
                  ['E12'] => 'upgrade=cost:60,terrain:water;border=edge:3,type:mountain;border=edge:4,type:mountain;border=edge:5,type:mountain',
                  ['F11'] => 'border=edge:4,type:mountain',
                  ['G12'] => 'border=edge:3,type:mountain;border=edge:4,type:mountain',
                  ['I14'] => 'border=edge:3,type:mountain',
                  ['F15'] => 'city=revenue:0;label=B',
                  ['G4'] => 'city=revenue:0;city=revenue:0;label=P',
                  %w[C6 F5 G16 H7] => 'town=revenue:0;town=revenue:0',
                  %w[H13] => 'town=revenue:0;town=revenue:0;border=edge:3,type:mountain;border=edge:4,type:mountain',
                },
                yellow: {
                  ['D17'] => 'city=revenue:20;path=a:0,b:_0;path=a:1,b:_0',
                  ['G2'] => 'city=revenue:20;path=a:2,b:_0;path=a:4,b:_0',
                  ['I6'] => 'path=a:1,b:3;stub=edge:2',
                  ['I8'] => 'city=revenue:20;path=a:2,b:_0;path=a:4,b:_0',
                },
                gray: {
                  ['A8'] => 'path=a:0,b:4;path=a:4,b:5;icon=image:1828/coal;icon=image:1828/coal;icon=image:1828/coal;icon=image:1828/coal',
                  ['A10'] => 'city=revenue:yellow_30|brown_70;path=a:0,b:_0;path=a:1,b:_0;path=a:1,b:_0;path=a:5,b:_0;',
                  ['B5'] => 'path=a:1,b:5;',
                  ['D1'] => 'town=revenue:20;path=a:3,b:_0;path=a:5,b:_0',
                  ['G18'] => 'path=a:0,b:2;',
                  ['I16'] => 'path=a:1,b:4;path=a:1,b:2;',
                },
                red: {
                  ['A2'] => 'offboard=revenue:yellow_40|brown_70,groups:Ireland;path=a:0,b:_0;border=edge:4',
                  ['A4'] => 'offboard=revenue:yellow_40|brown_70,hide:1,groups:Ireland;path=a:0,b:_0;border=edge:1',
                  ['C16'] => 'offboard=revenue:yellow_30|brown_50,hide:1,groups:Netherlands;path=a:0,b:_0;path=a:1,b:_0;path=a:5,b:_0;border=edge:4',
                  ['C18'] => 'offboard=revenue:yellow_30|brown_50,groups:Netherdlands;path=a:0,b:_0;border=edge:1',
                  ['B28'] => 'offboard=revenue:yellow_20|brown_30;path=a:0,b:_0;path=a:1,b:_0',
                  ['G3'] => 'offboard=revenue:yellow_40|brown_70;path=a:0,b:_0;path=a:4,b:_0;path=a:5,b:_0',
                  ['I1'] => 'offboard=revenue:yellow_20|brown_60;path=a:3,b:_0;path=a:4,b:_0;path=a:5,b:_0',
                  %w[K3 L16] => 'offboard=revenue:yellow_30|brown_40;path=a:2,b:_0;path=a:3,b:_0',
                },
              }.freeze
        end
      end
    end
  end
  