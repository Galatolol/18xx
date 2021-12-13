# frozen_string_literal: true

module Engine
  module Game
    module G18IrePL
      module Map
        TILES = {
          '3' => 3,
          '4' => 5,
          '5' => 4,
          '6' => 4,
          '7' => 4,
          '8' => 11,
          '9' => 9,
          '57' => 4,
          '58' => 5,
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
          '441' => 3,
          '442' => 3,
          '443' => 3,
          '444' => 3,
          '39' => 1,
          '40' => 1,
          '41' => 2,
          '42' => 2,
          '43' => 2,
          '44' => 1,
          '45' => 2,
          '46' => 2,
          '47' => 1,
          '611' => 11,
          'X1' => {
            'count' => 1,
            'color' => 'green',
            'code' => 'city=revenue:50,slots:2;path=a:2,b:_0;path=a:3,b:_0;path=a:5,b:_0;path=a:0,b:_0;label=W',
          },
          'X2' => {
            'count' => 1,
            'color' => 'green',
            'code' => 'town=revenue:10;path=a:0,b:_0;path=a:3,b:_0;path=a:3,b:5;label=R',
          },
          'X3' => {
            'count' => 1,
            'color' => 'green',
            'code' => 'town=revenue:10;path=a:0,b:_0;path=a:3,b:_0;path=a:3,b:1;label=R',
          },
          'X4' => {
            'count' => 1,
            'color' => 'brown',
            'code' => 'city=revenue:80,slots:2;path=a:0,b:_0;path=a:1,b:_0;path=a:2,b:_0;path=a:3,b:_0;path=a:4,b:_0;path=a:5,b:_0;label=W',
          },
        }.freeze

        LOCATION_NAMES = {
          'A5' => 'Szczecin',
          'A7' => 'Gorzów Wielkopolski',
          'A13' => 'Germany',
          'B10' => 'Zielona Góra',
          'B14' => 'Wałbrzych',
          'C9' => 'Poznań',
          'C13' => 'Wrocław',
          'C17' => 'Czechia',
          'D2' => 'Gdynia',
          'D6' => 'Bydgoszcz',
          'D10' => 'Kalisz',
          'D14' => 'Opole',
          'E1' => 'Sopot',
          'E3' => 'Gdańsk',
          'E7' => 'Toruń',
          'E19' => 'Cieszyn',
          'F10' => 'Kutno',
          'F12' => 'Łódź',
          'F16' => 'Katowice',
          'F18' => 'Bielsko-Biała',
          'G3' => 'Russia',
          'G5' => 'Olsztyn',
          'G7' => 'Ciechanów',
          'G11' => 'Łowicz',
          'G15' => 'Kielce',
          'G17' => 'Kraków',
          'G19' => 'Zakopane',
          'H10' => 'Warszawa',
          'H12' => 'Radom',
          'H18' => 'Tarnów',
          'I3' => 'Lithuania',
          'I17' => 'Rzeszów',
          'I19' => 'Slovakia',
          'J4' => 'Suwałki',
          'J14' => 'Lublin',
          'J18' => 'Przemyśl',
          'K5' => 'Belarus',
          'K7' => 'Białystok',
          'K9' => 'Biała Podlaska',
          'K15' => 'Zamość',
          'K17' => 'Ukraine',
        }.freeze

        HEXES = {
          white: {
            %w[A9 A11 B4 B8 B12 C3 C7 C11 C15 D4 D8 D12 D16 E9 E11 E13 E15 E17 F4 F6 F14 G13 H8 H14 I5 I7 I9
              J6 J10 J12 J16 K11 K13] => '',
            %w[E5 F8 G9 H4 H6 H16 I11 I13 I15] => 'upgrade=cost:30,terrain:water',
            %w[A5 C9 C13 D2 D6 F12 F16 J14] => 'city=revenue:0;',
            %w[E3 G5 G17 I17 K7] => 'city=revenue:0;upgrade=cost:30,terrain:water',
            %w[D10 D14 F10 G7 G11 G15 H18 J4 K9 K15] => 'town=revenue:0;',
            %w[E7] => 'town=revenue:0;upgrade=cost:30,terrain:water',
            %w[B10 B14] => 'town=revenue:0;icon=image:18_ire_pl/wor,sticky:1',
            %w[F18 G19] => 'town=revenue:0;icon=image:18_ire_pl/wor,sticky:1;upgrade=cost:30,terrain:mountain',
          },
          yellow: {
            ['H10'] => 'city=revenue:20;path=a:0,b:_0;label=W',
            ['H12'] => 'town=revenue:10;path=a:3,b:_0;path=a:0,b:_0;label=R',
          },
          blue: { 
            %w[A3 C1] => 'offboard=revenue:10;icon=image:port,sticky:1;path=a:0,b:_0;path=a:5,b:_0',
            ['F2'] => 'offboard=revenue:10;icon=image:port,sticky:1;path=a:0,b:_0;path=a:1,b:_0',
          },
          gray: {
            %w[A13 C17 G3 I3 I19 K5 K17] => '',
            ['E1'] => 'town=revenue:10;path=a:1,b:_0;path=a:0,b:_0',
            ['E19'] => 'town=revenue:10;path=a:3,b:_0;path=a:4,b:_0',
            ['J18'] => 'town=revenue:10;path=a:2,b:_0;path=a:3,b:_0',
            ['A7'] => 'town=revenue:10;path=a:3,b:_0;path=a:0,b:_0;path=a:0,b:4',
            ['B6'] => 'path=a:0,b:1;path=a:0,b:5;path=a:1,b:5;path=a:2,b:3;path=a:2,b:4;path=a:3,b:4',
            ['C5'] => 'path=a:0,b:3;path=a:0,b:4;path=a:3,b:4;path=a:1,b:2;path=a:1,b:5;path=a:2,b:5',
            ['J8'] => 'path=a:1,b:3;path=a:1,b:5;path=a:3,b:5;path=a:2,b:4;path=a:2,b:0;path=a:0,b:4',
          }
        }.freeze

        LAYOUT = :flat

        AXES = { x: :letter, y: :number }.freeze
      end
    end
  end
end
