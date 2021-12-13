# frozen_string_literal: true

module Engine
  module Game
    module G18IrePL
      module Map
        TILES = {
          '1' => 1,
          '3' => 5,
          '4' => 5,
          '5' => 1,
          '7' => 14,
          '8' => 18,
          '9' => 18,
          '19' => 1,
          '20' => 1,
          '55' => 1,
          '58' => 5,
          '60' => 2,
          '69' => 1,
          '77' => 8,
          '78' => 14,
          '79' => 14,
          '80' => { 'count' => 1, 'color' => 'green', 'code' => 'path=a:0,b:2;path=a:0,b:1;path=a:1,b:2' },
          '81' => { 'count' => 1, 'color' => 'green', 'code' => 'path=a:0,b:2;path=a:2,b:4;path=a:0,b:4' },
          '82' => { 'count' => 3, 'color' => 'green', 'code' => 'path=a:0,b:3;path=a:0,b:1;path=a:1,b:3' },
          '83' => { 'count' => 3, 'color' => 'green', 'code' => 'path=a:0,b:3;path=a:0,b:2;path=a:2,b:3' },
          '631' => 1,
          '644' => 1,
          '645' => 1,
          '657' => 1,
          '658' => 1,
          '659' => 1,
          '710' => 1,
          '711' => 1,
          '712' => 1,
          '713' => 1,
          '714' => 1,
          '715' => 1,
          'IR1' => {
            'count' => 2,
            'color' => 'yellow',
            'code' => 'city=revenue:30;city=revenue:30;path=a:3,b:_0;label=BC',
          },
          'IR2' => {
            'count' => 1,
            'color' => 'yellow',
            'code' => 'town=revenue:10;city=revenue:10;path=a:0,b:_0;'\
                      'path=a:2,b:_1;path=a:_1,b:3;label=DD;upgrade=cost:40',
          },
          'IR3' => {
            'count' => 1,
            'color' => 'yellow',
            'code' => 'city=revenue:10,slots:2;path=a:0,b:_0,track:narrow;path=a:1,b:_0;path=a:3,b:_0;label=EM',
          },
          'IR4' => {
            'count' => 1,
            'color' => 'yellow',
            'code' => 'city=revenue:10,slots:2;path=a:0,b:_0;path=a:2,b:_0;path=a:3,b:_0,track:narrow;label=EM',
          },
          'IR5' => { 'count' => 14, 'color' => 'yellow', 'code' => 'town=revenue:10;path=a:0,b:_0,track:narrow' },
          'IR6' => {
            'count' => 2,
            'color' => 'green',
            'code' => 'city=revenue:40;city=revenue:40;path=a:0,b:_0;path=a:4,b:_1;label=BC',
          },
          'IR7' => {
            'count' => 1, # @todo loc:3 should be center
            'color' => 'green',
            'code' => 'city=revenue:20,loc:2;town=revenue:10,loc:3;'\
                      'path=a:0,b:_0;path=a:2,b:_0;path=a:3,b:_0;path=a:0,b:_1;path=a:_1,b:3;label=DD',
          },
          'IR8' => { # @todo layout could be better
            'count' => 1,
            'color' => 'green',
            'code' => 'city=revenue:20,loc:3;town=revenue:10,loc:2;'\
                      'path=a:0,b:_0;path=a:2,b:_0;path=a:3,b:_0;path=a:0,b:_1;path=a:_1,b:2;label=DD',
          },
          'IR9' => {
            'count' => 1,
            'color' => 'green',
            'code' => 'city=revenue:40;city=revenue:40;path=a:0,b:_0;path=a:3,b:_1;label=DUB',
          },
          'IR10' => {
            'count' => 1,
            'color' => 'green',
            'code' => 'city=revenue:20,slots:2;path=a:0,b:_0;path=a:1,b:_0;'\
                      'path=a:3,b:_0,track:narrow;path=a:4,b:_0;label=EM',
          },
          'IR11' => {
            'count' => 1,
            'color' => 'green',
            'code' => 'city=revenue:20,slots:2;path=a:0,b:_0;path=a:1,b:_0;'\
                      'path=a:3,b:_0;path=a:4,b:_0,track:narrow;label=EM',
          },
          'IR12' => {
            'count' => 1,
            'color' => 'green',
            'code' => 'city=revenue:20,slots:2;path=a:0,b:_0;path=a:1,b:_0,track:narrow;'\
                      'path=a:2,b:_0;path=a:4,b:_0;label=EM',
          },
          'IR13' => {
            'count' => 1,
            'color' => 'green',
            'code' => 'town=revenue:10;path=a:0,b:_0;path=a:1,b:_0;path=a:2,b:_0,track:narrow;path=a:4,b:_0',
          },
          'IR14' => {
            'count' => 1,
            'color' => 'green',
            'code' => 'town=revenue:10;path=a:0,b:_0,track:narrow;path=a:1,b:_0;path=a:3,b:_0;path=a:4,b:_0',
          },
          'IR15' => {
            'count' => 1,
            'color' => 'green',
            'code' => 'town=revenue:10;path=a:0,b:_0;path=a:1,b:_0,track:narrow;path=a:2,b:_0;path=a:3,b:_0',
          },
          'IR16' => {
            'count' => 1,
            'color' => 'green',
            'code' => 'town=revenue:10;path=a:0,b:_0;path=a:1,b:_0;path=a:2,b:_0,track:narrow;path=a:3,b:_0',
          },
          'IR17' => {
            'count' => 1,
            'color' => 'green',
            'code' => 'town=revenue:10;path=a:0,b:_0;path=a:1,b:_0,track:narrow;path=a:3,b:_0;path=a:4,b:_0',
          },
          'IR18' => {
            'count' => 1,
            'color' => 'green',
            'code' => 'town=revenue:10;path=a:0,b:_0,track:narrow;path=a:1,b:_0;path=a:2,b:_0;path=a:4,b:_0',
          },
          'IR19' => {
            'count' => 1,
            'color' => 'green',
            'code' => 'town=revenue:10;path=a:0,b:_0;path=a:1,b:_0,track:narrow;path=a:2,b:_0;path=a:4,b:_0',
          },
          'IR20' => {
            'count' => 1,
            'color' => 'green',
            'code' => 'town=revenue:10;path=a:0,b:_0;path=a:1,b:_0;path=a:2,b:_0;path=a:3,b:_0,track:narrow',
          },
          'IR21' => {
            'count' => 1,
            'color' => 'green',
            'code' => 'town=revenue:10;path=a:0,b:_0;path=a:1,b:_0;path=a:2,b:_0;path=a:4,b:_0,track:narrow',
          },
          'IR22' => {
            'count' => 1,
            'color' => 'green',
            'code' => 'town=revenue:10;path=a:0,b:_0,track:narrow;path=a:1,b:_0;path=a:2,b:_0;path=a:3,b:_0',
          },
          'IR23' => {
            'count' => 2,
            'color' => 'green',
            'code' => 'town=revenue:10;path=a:0,b:_0,track:narrow;path=a:_0,b:3,track:narrow',
          },
          'IR24' => {
            'count' => 2,
            'color' => 'green',
            'code' => 'town=revenue:10;path=a:0,b:_0,track:narrow;path=a:_0,b:2,track:narrow',
          },
          'IR25' => {
            'count' => 2,
            'color' => 'green',
            'code' => 'town=revenue:10;path=a:0,b:_0,track:narrow;path=a:_0,b:1,track:narrow',
          },
          'IR26' => { 'count' => 1, 'color' => 'green', 'code' => 'path=a:0,b:3;path=a:1,b:2,track:narrow' },
          'IR27' => { 'count' => 1, 'color' => 'green', 'code' => 'path=a:0,b:3,track:narrow;path=a:1,b:2' },
          'IR28' => { 'count' => 1, 'color' => 'green', 'code' => 'path=a:1,b:3,track:narrow;path=a:0,b:4' },
          'IR29' => { 'count' => 1, 'color' => 'green', 'code' => 'path=a:0,b:1,track:narrow;path=a:2,b:4' },
          'IR30' => { 'count' => 1, 'color' => 'green', 'code' => 'path=a:1,b:2,track:narrow;path=a:0,b:4' },
          'IR31' => { 'count' => 1, 'color' => 'green', 'code' => 'path=a:1,b:2;path=a:0,b:4,track:narrow' },
          'IR32' => { 'count' => 1, 'color' => 'green', 'code' => 'path=a:0,b:1;path=a:2,b:4,track:narrow' },
          'IR33' => { 'count' => 1, 'color' => 'green', 'code' => 'path=a:0,b:1;path=a:2,b:3,track:narrow' },
          'IR34' => { 'count' => 1, 'color' => 'green', 'code' => 'path=a:0,b:1,track:narrow;path=a:3,b:4' },
          'IR35' => { 'count' => 1, 'color' => 'green', 'code' => 'path=a:0,b:1,track:narrow;path=a:2,b:3' },
          'IR36' => {
            'count' => 1,
            'color' => 'green',
            'code' => 'city=revenue:30,slots:2;path=a:0,b:_0;path=a:2,b:_0;path=a:3,b:_0,track:narrow',
          },
          'IR37' => {
            'count' => 1,
            'color' => 'green',
            'code' => 'city=revenue:30,slots:2;path=a:0,b:_0,track:narrow;path=a:2,b:_0;path=a:4,b:_0',
          },
          'IR38' => {
            'count' => 1,
            'color' => 'green',
            'code' => 'city=revenue:30,slots:2;path=a:0,b:_0,track:narrow;path=a:1,b:_0;path=a:3,b:_0',
          },
          'IR39' => {
            'count' => 1,
            'color' => 'green',
            'code' => 'city=revenue:30,slots:2;path=a:0,b:_0;path=a:1,b:_0,track:narrow;path=a:2,b:_0',
          },
          'IR40' => {
            'count' => 1,
            'color' => 'green',
            'code' => 'city=revenue:30,slots:2;path=a:0,b:_0;path=a:1,b:_0;path=a:2,b:_0,track:narrow',
          },
          'IR41' => {
            'count' => 1,
            'color' => 'green',
            'code' => 'city=revenue:30,slots:2;path=a:0,b:_0;path=a:1,b:_0;path=a:3,b:_0,track:narrow',
          },
          'IR42' => {
            'count' => 1,
            'color' => 'green',
            'code' => 'city=revenue:30,slots:2;path=a:0,b:_0,track:narrow;path=a:2,b:_0;path=a:3,b:_0',
          },
          'IR43' => {
            'count' => 1,
            'color' => 'green',
            'code' => 'city=revenue:30,slots:2;path=a:0,b:_0,track:narrow;path=a:1,b:_0;path=a:2,b:_0',
          },
          'IR44' => {
            'count' => 2,
            'color' => 'brown',
            'code' => 'city=revenue:50;city=revenue:50;path=a:0,b:_0;'\
                      'path=a:_0,b:1;path=a:2,b:_1;path=a:_1,b:3;label=BC',
          },
          'IR45' => {
            'count' => 1,
            'color' => 'brown',
            'code' => 'city=revenue:50,slots:2,loc:1.5;city=revenue:50;city=revenue:50;'\
                      'path=a:1,b:_0;path=a:_0,b:2;path=a:0,b:_1;path=a:3,b:_2;label=DUB',
          },
          'IR46' => {
            'count' => 1,
            'color' => 'brown',
            'code' => 'town=revenue:20;path=a:0,b:_0;path=a:1,b:_0;'\
                      'path=a:2,b:_0,track:narrow;path=a:3,b:_0,track:narrow;path=a:4,b:_0',
          },
          'IR47' => {
            'count' => 1,
            'color' => 'brown',
            'code' => 'town=revenue:20;path=a:0,b:_0;path=a:1,b:_0,track:narrow;'\
                      'path=a:2,b:_0;path=a:3,b:_0;path=a:4,b:_0,track:narrow',
          },
          'IR48' => {
            'count' => 1,
            'color' => 'brown',
            'code' => 'town=revenue:20;path=a:0,b:_0,track:narrow;path=a:1,b:_0;'\
                      'path=a:2,b:_0,track:narrow;path=a:3,b:_0;path=a:4,b:_0',
          },
          'IR49' => {
            'count' => 1,
            'color' => 'brown',
            'code' => 'town=revenue:20;path=a:0,b:_0;path=a:1,b:_0,track:narrow;'\
                      'path=a:2,b:_0,track:narrow;path=a:3,b:_0;path=a:4,b:_0',
          },
          'IR50' => {
            'count' => 1,
            'color' => 'brown',
            'code' => 'town=revenue:20;path=a:0,b:_0,track:narrow;path=a:1,b:_0;'\
                      'path=a:2,b:_0;path=a:3,b:_0,track:narrow;path=a:4,b:_0',
          },
          'IR51' => {
            'count' => 1,
            'color' => 'brown',
            'code' => 'town=revenue:20;path=a:0,b:_0;path=a:1,b:_0;'\
                      'path=a:2,b:_0,track:narrow;path=a:3,b:_0;path=a:4,b:_0,track:narrow',
          },
          'IR52' => {
            'count' => 1,
            'color' => 'brown',
            'code' => 'town=revenue:20;path=a:0,b:_0;path=a:1,b:_0,track:narrow;'\
                      'path=a:2,b:_0;path=a:3,b:_0,track:narrow;path=a:4,b:_0',
          },
          'IR53' => {
            'count' => 1,
            'color' => 'brown',
            'code' => 'town=revenue:20;path=a:0,b:_0,track:narrow;'\
                      'path=a:1,b:_0,track:narrow;path=a:2,b:_0;path=a:3,b:_0;path=a:4,b:_0',
          },
          'IR54' => {
            'count' => 1,
            'color' => 'brown',
            'code' => 'town=revenue:20;path=a:0,b:_0;path=a:1,b:_0;'\
                      'path=a:2,b:_0;path=a:3,b:_0,track:narrow;path=a:4,b:_0,track:narrow',
          },
          'IR55' => {
            'count' => 1,
            'color' => 'brown',
            'code' => 'town=revenue:20;path=a:0,b:_0,track:narrow;path=a:1,b:_0;'\
                      'path=a:2,b:_0;path=a:3,b:_0;path=a:4,b:_0,track:narrow',
          },
          'IR56' => {
            'count' => 1,
            'color' => 'brown',
            'code' => 'town=revenue:10;path=a:0,b:_0,track:narrow;'\
                      'path=a:2,b:_0,track:narrow;path=a:3,b:_0,track:narrow',
          },
          'IR57' => {
            'count' => 1,
            'color' => 'brown',
            'code' => 'town=revenue:10;path=a:0,b:_0,track:narrow;'\
                      'path=a:1,b:_0,track:narrow;path=a:3,b:_0,track:narrow',
          },
          'IR58' => {
            'count' => 1,
            'color' => 'brown',
            'code' => 'town=revenue:10;path=a:0,b:_0,track:narrow;'\
                      'path=a:2,b:_0,track:narrow;path=a:4,b:_0,track:narrow',
          },
          'IR59' => {
            'count' => 1,
            'color' => 'brown',
            'code' => 'path=a:0,b:2;path=a:0,b:1;path=a:1,b:2;'\
                      'path=a:3,b:4;path=a:3,b:5;path=a:4,b:5',
          },
          'IR60' => {
            'count' => 1,
            'color' => 'brown',
            'code' => 'path=a:0,b:2;path=a:1,b:3;path=a:2,b:4;path=a:3,b:5;path=a:0,b:4;path=a:1,b:5',
          },
          'IR61' => {
            'count' => 2,
            'color' => 'brown',
            'code' => 'path=a:0,b:3;path=a:1,b:4;path=a:1,b:2;path=a:2,b:4;path=a:3,b:5;path=a:0,b:5',
          },
          'IR62' => {
            'count' => 1,
            'color' => 'brown',
            'code' => 'city=revenue:40,slots:2;path=a:0,b:_0,track:narrow;path=a:1,b:_0;path=a:2,b:_0;path=a:3,b:_0',
          },
          'IR63' => {
            'count' => 1,
            'color' => 'brown',
            'code' => 'city=revenue:40,slots:2;path=a:0,b:_0;path=a:1,b:_0,track:narrow;path=a:2,b:_0;path=a:3,b:_0',
          },
          'IR64' => {
            'count' => 1,
            'color' => 'brown',
            'code' => 'city=revenue:40,slots:2;path=a:0,b:_0;path=a:1,b:_0;path=a:2,b:_0,track:narrow;path=a:3,b:_0',
          },
          'IR65' => {
            'count' => 1,
            'color' => 'brown',
            'code' => 'city=revenue:40,slots:2;path=a:0,b:_0;path=a:1,b:_0;path=a:2,b:_0;path=a:3,b:_0,track:narrow',
          },
          'IR66' => {
            'count' => 1,
            'color' => 'brown',
            'code' => 'city=revenue:40,slots:2;path=a:0,b:_0;path=a:1,b:_0;'\
                      'path=a:2,b:_0;path=a:3,b:_0,track:narrow;path=a:4,b:_0;path=a:5,b:_0',
          },
          'IR67' => {
            'count' => 2,
            'color' => 'gray',
            'code' => 'city=revenue:60,slots:2;path=a:0,b:_0;path=a:1,b:_0;path=a:2,b:_0;path=a:3,b:_0;label=BC',
          },
          'IR68' => {
            'count' => 1,
            'color' => 'gray',
            'code' => 'city=revenue:60,slots:4;path=a:0,b:_0;path=a:1,b:_0;path=a:2,b:_0;path=a:3,b:_0;label=DUB',
          },
          'IR69' => {
            'count' => 1,
            'color' => 'gray',
            'code' => 'town=revenue:20;path=a:0,b:_0,track:narrow;path=a:1,b:_0;'\
                      'path=a:2,b:_0;path=a:3,b:_0,track:narrow;path=a:4,b:_0,track:narrow;path=a:5,b:_0',
          },
          'IR70' => {
            'count' => 1,
            'color' => 'gray',
            'code' => 'town=revenue:20;path=a:0,b:_0,track:narrow;path=a:1,b:_0;'\
                      'path=a:2,b:_0;path=a:3,b:_0,track:narrow;path=a:4,b:_0;path=a:5,b:_0,track:narrow',
          },
          'IR71' => {
            'count' => 1,
            'color' => 'gray',
            'code' => 'town=revenue:20;path=a:0,b:_0,track:narrow;path=a:1,b:_0,track:narrow;'\
                      'path=a:2,b:_0;path=a:3,b:_0;path=a:4,b:_0;path=a:5,b:_0,track:narrow',
          },
          'IR72' => {
            'count' => 1,
            'color' => 'gray',
            'code' => 'town=revenue:20;path=a:0,b:_0,track:narrow;path=a:1,b:_0;'\
                      'path=a:2,b:_0,track:narrow;path=a:3,b:_0;path=a:4,b:_0,track:narrow;path=a:5,b:_0',
          },
          'IM' => {
            'count' => 1,
            'color' => 'red',
            'code' => 'offboard=revenue:green_20|brown_50|gray_0;path=a:5,b:_0',
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
