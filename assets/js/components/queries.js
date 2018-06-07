export default (playerItems, countryItems, stadiumItems) => {
    return [
        {
            id: 'player_participation',
            name: 'Player Participation',
            prompts: [
                {
                    id: 'name', 
                    prompt: 'Name',
                    type: 'autocomplete',
                    items: playerItems
                },
                {
                    id: 'country', 
                    prompt: 'Country',
                    type: 'autocomplete',
                    items: countryItems
                },
                {
                    id: 'year',
                    prompt: 'Year',
                    type: 'number'
                }
            ],
        },
        {
            id: 'player_career',
            name: 'Player Career',
            prompts: [
                {
                    id: 'name', 
                    prompt: 'Name',
                    type: 'autocomplete',
                    items: playerItems
                },
                {
                    id: 'country', 
                    prompt: 'Country',
                    type: 'autocomplete',
                    items: countryItems
                },
                {
                    id: 'min_num_goals',
                    prompt: 'Min Num Goals',
                    type: 'number'
                },
                {
                    id: 'min_num_cups',
                    prompt: 'Min Num Cups',
                    type: 'number'
                }
            ]
        },
        {
            id: 'country_participation',
            name: 'Country Participation',
            prompts: [
                {
                    id: 'year',
                    prompt: 'Year',
                    type: 'number'
                },
                {
                    id: 'country',
                    prompt: 'Country',
                    type: 'autocomplete',
                    items: countryItems
                }
            ]
        },
        {
            id: 'country_historical',
            name: 'Country Historical',
            prompts: [
                {
                    id: 'country',
                    prompt: 'Country',
                    type: 'autocomplete',
                    items: countryItems
                },
                {
                    id: 'min_num_cups',
                    prompt: 'Min Num Cups',
                    type: 'number'
                },
                {
                    id: 'min_num_wins',
                    prompt: 'Min Num Wins',
                    type: 'number'
                },
                {
                    id: 'min_num_goals',
                    prompt: 'Min Num Goals',
                    type: 'number'
                }
            ]
        },
        {
            id: 'match',
            name: 'Match',
            prompts: [
                {
                    id: 'year',
                    prompt: 'Year',
                    type: 'number'
                },
                {
                    id: 'country_a',
                    prompt: 'Country A',
                    type: 'autocomplete',
                    items: countryItems
                },
                {
                    id: 'country_b',
                    prompt: 'Country B',
                    type: 'autocomplete',
                    items: countryItems
                },
                {
                    id: 'stadium',
                    prompt: 'Stadium',
                    type: 'autocomplete',
                    items: stadiumItems
                },
                {
                    id: 'min_mov',
                    prompt: 'Min Margin of Victory',
                    type: 'number'
                },
                {
                    id: 'went_to_pks',
                    prompt: 'Went to PKs',
                    type: 'select',
                    items: [
                        {
                            name: 'Either',
                            value: null
                        },
                        {
                            name: 'True',
                            value: true
                        },
                        {
                            name: 'False',
                            value: false
                        }
                    ]
                }
            ]
        }
    ]
}