# frozen_string_literal: true

module Engine
    module Game
      module G1839
        module Entities
          COMPANIES = [
            {
              name: 'Ligne Longwy-Villerupt-Micheville',
              sym: 'LVM',
              value: 20,
              revenue: 5,
              desc: 'Owning corporation may lay a yellow tile in I14.'\
                    ' This is in addition to the corporation\'s tile builds.'\
                    ' No connection required. Blocks I14 while owned by a player.',
              color: '#d9d9d9',
            },
            # {
            #   name: 'Antwerpen-Rotterdamsche Spoorwegmaatschappij',
            #   sym: 'AR',
            #   value: 25,
            #   revenue: 5,
            #   desc: 'When owned by a corporation, the revenue is equal to 10.',
            #   abilities: [{ type: 'revenue_change', revenue: 10, when: 'sold' }],
            #   color: '#d9d9d9',
            # },
            # {
            #   name: 'Gare de Liège-Guillemins',
            #   sym: 'GLG',
            #   value: 50,
            #   revenue: 10,
            #   desc: 'Owning corporation may lay a yellow tile or upgrade a yellow tile in Liège'\
            #         ' (H17) along with an optional token.'\
            #         ' This counts as one of the corporation\'s tile builds.'\
            #         ' Blocks H17 while owned by a player.',
            #   abilities: [{ type: 'blocks_hexes', owner_type: 'player', hexes: ['H17'] },
            #               {
            #                 type: 'teleport',
            #                 owner_type: 'corporation',
            #                 hexes: ['H17'],
            #                 tiles: %w[14 15 57 619],
            #               }],
            #   color: '#d9d9d9',
            # },
            # {
            #   name: 'London shipping',
            #   sym: 'LS',
            #   value: 90,
            #   revenue: 15,
            #   desc: 'Owning corporation may place its cheapest available token for free in A12.'\
            #         ' The value of London (A10) is increased, for this corporation only,'\
            #         ' by the largest non-London, non-Luxembourg revenue on the route.',
            #   abilities: [{
            #     type: 'token',
            #     when: 'owning_corp_or_turn',
            #     hexes: ['A12'],
            #     count: 1,
            #     price: 0,
            #     teleport_price: 0,
            #     extra_action: true,
            #     from_owner: true,
            #     owner_type: 'corporation',
            #   }],
            #   color: '#d9d9d9',
            # },
            # {
            #   name: 'Ligne de Saint-Quentin à Guise',
            #   sym: 'SQG',
            #   value: 100,
            #   desc: 'Revenue is equal to 70 if Saint-Quentin (G10) is green, to 100 if Saint-Quentin is brown and to 0 otherwise.'\
            #         ' Closes in purple phase.',
            #   abilities: [{ type: 'close', on_phase: 'Purple' }],
            #   color: '#d9d9d9',
            # },
            # {
            #   name: 'Nord minor shareholding',
            #   sym: 'NMinorS',
            #   value: 140,
            #   revenue: 20,
            #   desc: 'Owning player immediately receives a 10% share of the Nord without further payment.',
            #   color: '#d9d9d9',
            # },
            # {
            #   name: 'PLM major shareholding',
            #   sym: 'PLMMS',
            #   value: 180,
            #   revenue: 25,
            #   desc: 'Owning player immediately receives the President\'s certificate of the'\
            #         ' PLM without further payment. This private company may not be sold to any corporation, and does'\
            #         ' not exchange hands if the owning player loses the Presidency of the PLM.'\
            #         ' Closes when the PLM operates.',
            #   abilities: [{ type: 'close', when: 'operated', corporation: 'PLM' },
            #               { type: 'no_buy' },
            #               { type: 'shares', shares: 'PLM_0' }],
            #   color: '#dda0dd',
            # },
            # {
            #   name: 'Ouest major shareholding',
            #   sym: 'OMMS',
            #   value: 180,
            #   revenue: 25,
            #   desc: 'Owning player immediately receives the President\'s certificate of the'\
            #         ' Ouest without further payment. This private company may not be sold to any corporation, and does'\
            #         ' not exchange hands if the owning player loses the Presidency of the Ouest.'\
            #         ' Closes when the Ouest operates.',
            #   abilities: [{ type: 'close', when: 'operated', corporation: 'Ouest' },
            #               { type: 'no_buy' },
            #               { type: 'shares', shares: 'Ouest_0' }],
            #   color: '#4682b4',
            # },
            # {
            #   name: 'Nord major shareholding',
            #   sym: 'NMS',
            #   value: 180,
            #   revenue: 25,
            #   desc: 'Owning player immediately receives the President\'s certificate of the'\
            #         ' Nord without further payment. This private company may not be sold to any corporation, and does'\
            #         ' not exchange hands if the owning player loses the Presidency of the Nord.'\
            #         ' Closes when the Nord operates.',
            #   abilities: [{ type: 'close', when: 'operated', corporation: 'Nord' },
            #               { type: 'no_buy' },
            #               { type: 'shares', shares: 'Nord_0' }],
            #   color: '#ff4040',
            # },
            # {
            #   name: 'CFOR major shareholding',
            #   sym: 'CMS',
            #   value: 180,
            #   revenue: 25,
            #   desc: 'Owning player immediately receives the President\'s certificate of the'\
            #         ' CFOR without further payment. This private company may not be sold to any corporation, and does'\
            #         ' not exchange hands if the owning player loses the Presidency of the CFOR.'\
            #         ' Closes when the CFOR operates.',
            #   abilities: [{ type: 'close', when: 'operated', corporation: 'CFOR' },
            #               { type: 'no_buy' },
            #               { type: 'shares', shares: 'CFOR_0' }],
            #   color: '#9c661f',
            #   text_color: 'white',
            # },
            # {
            #   name: 'Est major shareholding',
            #   sym: 'EMS',
            #   value: 180,
            #   revenue: 25,
            #   desc: 'Owning player immediately receives the President\'s certificate of the'\
            #         ' Est without further payment. This private company may not be sold to any corporation, and does'\
            #         ' not exchange hands if the owning player loses the Presidency of the Est.'\
            #         ' Closes when the Est operates.',
            #   abilities: [{ type: 'close', when: 'operated', corporation: 'Est' },
            #               { type: 'no_buy' },
            #               { type: 'shares', shares: 'Est_0' }],
            #   color: '#ff9966',
            # },
            # {
            #   name: 'Belge major shareholding',
            #   sym: 'BMS',
            #   value: 200,
            #   revenue: 30,
            #   desc: 'Owning player immediately receives the President\'s certificate of the'\
            #         ' Belge without further payment. This private company may not be sold to any corporation, and does'\
            #         ' not exchange hands if the owning player loses the Presidency of the Belge.'\
            #         ' Closes when the Belge operates.',
            #   abilities: [{ type: 'close', when: 'operated', corporation: 'Belge' },
            #               { type: 'no_buy' },
            #               { type: 'shares', shares: 'Belge_0' }],
            #   color: '#61b229',
            # },
          ].freeze

          CORPORATIONS = [
            {
              sym: 'AMS',
              name: 'Aken-Maastrichtsche Spoorweg-Maatschappij',
              logo: '1894/PLM',
              simple_logo: '1894/PLM.alt',
              tokens: [0, 40, 100, 100, 140],
              max_ownership_percent: 60,
              local: false,
              coordinates: 'L13',
              color: '#dda0dd',
              text_color: 'black',
            },
            {
              sym: 'L1',
              name: 'Lokaalsporwegen 1',
              logo: '1894/Belge',
              simple_logo: '1894/Belge.alt',
              tokens: [0, 40, 100],
              max_ownership_percent: 60,
              local: true,
              coordinates: 'L17',
              color: '#61b229',
              abilities: [
                {
                  type: 'description',
                  description: 'Local',
                },
              ],
            },
          ].freeze
        end
      end
    end
  end
