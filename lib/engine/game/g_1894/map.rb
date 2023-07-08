# frozen_string_literal: true

module Engine
  module Game
    module G1894
      module Map
        TILES = {
          '1' => 1,
          '7' => 3,
          '8' => 12,
          '9' => 9,
          '14' => 4,
          '15' => 4,
          '16' => 1,
          '17' => 1,
          '18' => 1,
          '19' => 1,
          '20' => 1,
          '23' => 3,
          '24' => 3,
          '25' => 2,
          '26' => 2,
          '27' => 2,
          '28' => 1,
          '29' => 1,
          '30' => 1,
          '31' => 1,
          '35' => 2,
          '36' => 2,
          '39' => 1,
          '40' => 1,
          '41' => 2,
          '42' => 2,
          '43' => 1,
          '44' => 1,
          '45' => 2,
          '46' => 2,
          '47' => 1,
          '56' => 1,
          '57' => 10,
          '70' => 2,
          '118' => 2,
          '619' => 4,
          '624' => 1,
          '630' => 1,
          '631' => 1,
          '632' => 1,
          '633' => 1,
          'X1' => {
            'count' => 1,
            'color' => 'yellow',
            'code' => 'city=revenue:30,loc:0.5,reservation:PLM;city=revenue:30;upgrade=cost:50,terrain:water;path=a:0,b:_0;path=a:1,b:_0;path=a:3,b:_1;label=P',
          },
          'X2' => {
            'count' => 1,
            'color' => 'yellow',
            'code' => 'city=revenue:30;upgrade=cost:50,terrain:water;path=a:0,b:_0;path=a:2,b:_0;label=B',
          },
          'X3' => {
            'count' => 1,
            'color' => 'yellow',
            'code' => 'city=revenue:30;upgrade=cost:50,terrain:water;path=a:0,b:_0;path=a:1,b:_0;label=L',
          },
          'X4' => {
            'count' => 1,
            'color' => 'green',
            'code' => 'city=revenue:40,loc:0.5;city=revenue:40,loc:2.5;upgrade=cost:50,terrain:water;'\
                      'path=a:0,b:_0;path=a:1,b:_0;path=a:2,b:_1;path=a:3,b:_1;label=P',
          },
          'X5' => {
            'count' => 1,
            'color' => 'green',
            'code' => 'city=revenue:40,loc:0.5;city=revenue:40,loc:3.5;upgrade=cost:50,terrain:water;'\
                      'path=a:0,b:_0;path=a:1,b:_0;path=a:3,b:_1;path=a:4,b:_1;label=P',
          },
          'X6' => {
            'count' => 1,
            'color' => 'green',
            'code' => 'city=revenue:50,slots:2;upgrade=cost:50,terrain:water;path=a:0,b:_0;path=a:2,b:_0;path=a:4,b:_0;label=B',
          },
          'X7' => {
            'count' => 1,
            'color' => 'green',
            'code' => 'city=revenue:50;upgrade=cost:50,terrain:water;path=a:0,b:_0;path=a:1,b:_0;path=a:4,b:_0;label=L',
          },
          'X8' => {
            'count' => 1,
            'color' => 'green',
            'code' => 'city=revenue:40,slots:2;upgrade=cost:50,terrain:water;path=a:0,b:_0;path=a:1,b:_0;path=a:3,b:_0;path=a:4,b:_0;label=L',
          },
          'X9' => {
            'count' => 1,
            'color' => 'brown',
            'code' => 'city=revenue:80,loc:0.5;city=revenue:80,slots:2;'\
                      'path=a:0,b:_0;path=a:1,b:_0;path=a:2,b:_1;path=a:3,b:_1;label=P',
          },
          'X10' => {
            'count' => 1,
            'color' => 'brown',
            'code' => 'city=revenue:80,loc:0.5;city=revenue:80,slots:2:;'\
                      'path=a:0,b:_0;path=a:1,b:_0;path=a:3,b:_1;path=a:4,b:_1;label=P',
          },
          'X11' => {
            'count' => 1,
            'color' => 'brown',
            'code' => 'city=revenue:60,slots:3;path=a:0,b:_0;path=a:2,b:_0;path=a:3,b:_0;path=a:4,b:_0;label=B',
          },
          'X12' => {
            'count' => 1,
            'color' => 'brown',
            'code' => 'city=revenue:60,slots:2;path=a:0,b:_0;path=a:1,b:_0;path=a:3,b:_0;path=a:4,b:_0;label=L',
          },
          'X13' => {
            'count' => 1,
            'color' => 'brown',
            'code' => 'city=revenue:50,slots:3;path=a:0,b:_0;path=a:1,b:_0;path=a:2,b:_0;'\
                      'path=a:3,b:_0;path=a:4,b:_0;path=a:5,b:_0;label=L',
          },
          'X14' => {
            'count' => 2,
            'color' => 'brown',
            'code' => 'city=revenue:40;city=revenue:40,loc:3.5;path=a:0,b:_0;path=a:2,b:_0;path=a:3,b:_1;path=a:4,b:_1',
          },
          'X15' => {
            'count' => 2,
            'color' => 'brown',
            'code' => 'city=revenue:40;city=revenue:40,loc:2.5;path=a:0,b:_0;path=a:4,b:_0;path=a:2,b:_1;path=a:3,b:_1',
          },
          'X16' => {
            'count' => 2,
            'color' => 'brown',
            'code' => 'city=revenue:40;city=revenue:40,loc:1.5;path=a:0,b:_0;path=a:3,b:_0;path=a:1,b:_1;path=a:2,b:_1',
          },
          'X17' => {
            'count' => 2,
            'color' => 'brown',
            'code' => 'city=revenue:40;city=revenue:40;path=a:0,b:_0;path=a:3,b:_0;path=a:2,b:_1;path=a:4,b:_1',
          },
          'X18' => {
            'count' => 2,
            'color' => 'brown',
            'code' => 'city=revenue:40;city=revenue:40;path=a:0,b:_0;path=a:3,b:_0;path=a:1,b:_1;path=a:4,b:_1',
          },
          'X19' => {
            'count' => 2,
            'color' => 'brown',
            'code' => 'city=revenue:40,loc:0.5;city=revenue:40,loc:3.5;'\
                      'path=a:0,b:_0;path=a:1,b:_0;path=a:3,b:_1;path=a:4,b:_1',
          },
        }.freeze

        LOCATION_NAMES = {
          'A1' => 'Great Britain',
          'A9' => 'London',
          'A11' => 'London shipping',
          'B3' => 'Le Havre',
          'B8' => 'Calais',
          'B10' => 'Dunkerque',
          'B14' => 'Brugge',
          'B18' => 'Netherlands',
          'C3' => 'Rouen',
          'C11' => 'Lille',
          'C15' => 'Gent',
          'C17' => 'Antwerpen',
          'D2' => 'Évreux',
          'D8' => 'Amiens',
          'D10' => 'Arras',
          'D14' => 'Bruxelles',
          'D16' => 'Mechelen',
          'E13' => 'Mons',
          'E5' => 'Paris',
          'F4' => 'Versailles',
          'F8' => 'Saint-Quentin',
          'F2' => 'Chartres',
          'F14' => 'Charleroi',
          'F16' => 'Liège',
          'F18' => 'Hasselt',
          'G1' => 'Centre & Bourgogne',
          'G7' => 'Reims',
          'G15' => 'Namur',
          'G17' => 'Luxembourg',
        }.freeze

        HEXES = {
          white: {
            %w[C1 C9 D6 D18 E1 E15 E17 G5] => '',
            %w[B2 B4 C5 E3 E7 G3 G9] => 'upgrade=cost:50,terrain:water',
            %w[A3 B14 C3 C15 C17 D2 D8 D10 D16 F4 F14 G15] => 'city=revenue:0',
            %w[B8 F8 F16] => 'city=revenue:0;upgrade=cost:50,terrain:water',
            %w[B6 C7 D4 E9 F6] => 'town=revenue:0;town=revenue:0',
            ['A5'] => 'border=edge:4,type:impassable',
            ['A7'] => 'upgrade=cost:50,terrain:water;border=edge:1,type:impassable',
            ['B10'] => 'city=revenue:0;upgrade=cost:50,terrain:water;border=edge:4,type:mountain',
            ['B12'] => 'border=edge:0,type:mountain;border=edge:1,type:mountain',
            ['C11'] => 'city=revenue:0;label=L;border=edge:3,type:mountain;border=edge:4,type:mountain',
            ['C13'] => 'town=revenue:0;town=revenue:0;border=edge:0,type:mountain;border=edge:1,type:mountain',
            ['D12'] => 'upgrade=cost:50,terrain:water;border=edge:3,type:mountain;border=edge:4,type:mountain;border=edge:5,type:mountain',
            ['D14'] => 'city=revenue:0;label=B;border=edge:1,type:mountain',
            ['E5'] => 'city=revenue:0;city=revenue:0;label=P',
            ['E11'] => 'upgrade=cost:50,terrain:water;border=edge:4,type:mountain;border=edge:5,type:mountain',
            ['E13'] => 'city=revenue:0;border=edge:1,type:mountain;border=edge:2,type:mountain',
            ['F10'] => 'upgrade=cost:50,terrain:water;border=edge:4,type:mountain',
            ['F12'] => 'border=edge:0,type:mountain;border=edge:1,type:mountain;border=edge:2,type:mountain',
            ['G11'] => 'border=edge:3,type:mountain;border=edge:4,type:mountain',
            ['G13'] => 'border=edge:1,type:mountain',
          },
          yellow: {
            ['G7'] => 'city=revenue:10;upgrade=cost:50,terrain:water;path=a:2,b:_0;path=a:4,b:_0',
          },
          gray: {
            ['A13'] => 'town=revenue:20;path=a:0,b:_0;path=a:5,b:_0',
            ['B16'] => 'path=a:0,b:1;path=a:4,b:5;path=a:5,b:0',
            ['F0'] => 'town=revenue:20;path=a:4,b:_0;path=a:5,b:_0',
            ['F2'] => 'city=revenue:yellow_20|brown_30;path=a:2,b:_0;path=a:4,b:_0;path=a:1,b:_0;',
            ['F18'] => 'city=revenue:30;path=a:1,b:_0;path=a:2,b:_0',
          },
          blue: {
            ['A9'] => 'town=revenue:yellow_30|brown_70;path=a:0,b:_0;path=a:1,b:_0;path=a:5,b:_0',
            ['A11'] => 'city=revenue:0;icon=image:1894/ferry;icon=image:1894/ferry;icon=image:1894/ferry',
          },
          red: {
            ['A1'] => 'offboard=revenue:50;icon=image:1894/coins;path=a:4,b:_0;path=a:5,b:_0',
            ['B18'] => 'offboard=revenue:30;icon=image:1894/port;path=a:0,b:_0;path=a:1,b:_0',
            ['G1'] => 'offboard=revenue:40;icon=image:1894/coins;path=a:2,b:_0;path=a:4,b:_0',
            ['G17'] => 'offboard=revenue:0,hide:1;icon=image:1894/largest;icon=image:1894/coins;path=a:1,b:_0;path=a:2,b:_00',
          },
        }.freeze
      end
    end
  end
end
