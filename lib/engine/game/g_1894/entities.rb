# frozen_string_literal: true

module Engine
    module Game
      module G1894
        module Entities
          COMPANIES = [
            {
              name: 'Ligne Longwy-Villerupt-Micheville',
              sym: 'LVM',
              value: 20,
              revenue: 5,
              desc: 'Owning corporation may lay a yellow tile in I14.'\
                    ' This is in addition ot the corporations\'s normal tile build.'\
                    ' No connection required. Blocks I14 while owned by a player.',
              abilities: [{ type: 'blocks_hexes', owner_type: 'player', hexes: ['I14'] },
                          {
                            type: 'tile_lay',
                            owner_type: 'corporation',
                            hexes: ['I14'],
                            tiles: %w[7 8 9],
                            when: 'owning_corp_or_turn',
                            count: 1,
                          }],
            },
            {
              name: 'Chrleroi-Sud',
              sym: 'CS',
              value: 50,
              revenue: 10,
              desc: 'Owning corporation may lay or upgrade a tile in Charleroi (G14) along with an optional station marker.'\
                    ' This is in addition to the corporation\'s normal tile build. The cost of the station marker must be paid'\
                    ' by the corporation cannot place another station marker in this operating round. Blocks B20 while owned by a player.',
              abilities: [{ type: 'blocks_hexes', owner_type: 'player', hexes: ['G14'] },
                          {
                            type: 'tile_lay',
                            when: 'track',
                            owner_type: 'corporation',
                            free: true,
                            reachable: false,
                            hexes: ['G14'],
                            tiles: %w[14 15 35 36 57 118 619 X10 X11 X12 X13 X14 X15],
                            count: 1,
                          },
                          {
                            type: 'token',
                            owner_type: 'corporation',
                            price: 0,
                            teleport_price: 0,
                            reachable: false,
                            hexes: ['G14'],
                            count: 1,
                            }],
            },
            {
              name: 'Ligne de Saint-Quentin à Guise',
              sym: 'SQG',
              value: 80,
              revenue: 10,
              desc: 'This private company never closes. The revenue is equal to the value of Saint-Quentin (G10).',
              abilities: [{ type: 'revenue_change', revenue: 0, when: 'auction_end' }],
            },
            {
              name: 'Port company',
              sym: 'PC',
              value: 100,
              revenue: 15,
              desc: 'Owning corporation may place a +10 marker in England (A10). For this corporation only the value'\
                    ' of England is considered to be 10 higher.',
              abilities: [{
                            type: 'assign_hexes',
                            when: 'owning_corp_or_turn',
                            hexes: ['A10'],
                            count: 1,
                            owner_type: 'corporation',
                          },
                          {
                            type: 'assign_corporation',
                            when: 'sold',
                            count: 1,
                            owner_type: 'corporation',
                          }],
            },
            {
              name: 'CAB minor shareholding',
              sym: 'CABMS',
              value: 140,
              revenue: 20,
              desc: 'Owning player immediately receives a 10% share of the CAB without further payment.',
              abilities: [{ type: 'shares', shares: 'CAB_1' }],
            },
            {
              name: 'PLM major shareholding',
              sym: 'PLMMS',
              value: 180,
              revenue: 25,
              desc: 'Owning player immediately receives the President\'s certificate of the'\
                    ' PLM without further payment. This private company may not be sold to any corporation, and does'\
                    ' not exchange hands if the owning player loses the Presidency of the PLM.'\
                    ' When the PLM purchases its first train, the private company is closed.',
              abilities: [{ type: 'close', when: 'bought_train', corporation: 'PLM' },
                          { type: 'no_buy' },
                          { type: 'shares', shares: 'PLM_0' }],
            },
          ].freeze

          CORPORATIONS = [
            {
              sym: 'Ouest',
              name: 'Chemins de fer de l\'Ouest',
              logo: '1828/BM',
              simple_logo: '1828/BM.alt',
              tokens: [0, 40, 60, 80, 100],
              coordinates: 'D3',
              color: '#4682b4',
            },
            {
              sym: 'Nord',
              name: 'Chemins de fer du Nord',
              logo: '1828/BM',
              simple_logo: '1828/BM.alt',
              tokens: [0, 40, 60, 80, 100],
              coordinates: 'D11',
              color: '#ff4040',
            },
            {
              sym: 'GR',
              name: 'Gent Railway',
              logo: '1828/BM',
              simple_logo: '1828/BM.alt',
              tokens: [0, 40, 60, 80, 100],
              coordinates: 'D15',
              color: '#fcf75e',
              text_color: 'black',
            },
            {
              sym: 'CAB',
              name: 'Chemins de fer d\'Amiens à Boulogne',
              logo: '1828/BM',
              simple_logo: '1828/BM.alt',
              tokens: [0, 40, 60, 80, 100],
              coordinates: 'E6',
              color: '#9c661f',
            },
            {
              sym: 'Belge',
              name: 'Chemins de fer de l\'État belge',
              logo: '1828/BM',
              simple_logo: '1828/BM.alt',
              tokens: [0, 40, 60, 80, 100],
              coordinates: 'F15',
              color: '#61b229',
            },
            {
              sym: 'PLM',
              name: 'Chemins de fer de Paris à Lyon et à la Méditerranée',
              logo: '1828/BM',
              simple_logo: '1828/BM.alt',
              tokens: [0, 40, 60, 80],
              coordinates: 'G4',
              city: 0,
              color: '#dda0dd',
            },
            {
              sym: 'Est',
              name: 'Chemins de fer de l\'Est',
              logo: '1828/BM',
              simple_logo: '1828/BM.alt',
              tokens: [0, 40, 60, 80, 100],
              coordinates: 'I8',
              color: '#ff9966',
            },
            {
              sym: 'F1',
              name: 'French 1',
              logo: '1828/BM',
              simple_logo: '1828/BM.alt',
              tokens: [0, 40],
              color: '#ffc0cb',
              text_color: 'black',
            },
            {
              sym: 'F2',
              name: 'French 2',
              logo: '1828/BM',
              simple_logo: '1828/BM.alt',
              tokens: [0, 40],
              color: 'lime',
              text_color: 'black',
            },
            {
                sym: 'B1',
                name: 'Belgian 1',
                logo: '1828/BM',
                simple_logo: '1828/BM.alt',
                tokens: [0, 40],
                color: '#c9c9c9',
                text_color: 'black',
            },
            {
              sym: 'B2',
              name: 'Belgian 2',
              logo: '1828/BM',
              simple_logo: '1828/BM.alt',
              tokens: [0, 40],
              color: '#ffefdb',
              text_color: 'black',
            },
          ].freeze
        end
      end
    end
  end
  