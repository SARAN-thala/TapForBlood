# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create([
                { name: 'Sajani',
                  phone_number: '+919840692259',
                  blood_group: 'AB+',
                  latitude: '13.060422',
                  longitude: '80.249583',
                  area: 'Velachery'
                },
                { name: 'Raji',
                  phone_number: '+919840692259',
                  blood_group: 'O+',
                  latitude: '13.460422',
                  longitude: '80.649583',
                  area: 'Nandanam',
                  registration_id: 'APA91bG9mNBxxVenXQoarY0ZZ5Agxvu2TEP9TphIkfdic9UGveU399DyY4xABh8KrsRZav6O5RMoICXSY1vDPJQSZBl-3a99c5OJuLg4tagvmC_oNW3YiWytvnMatHHSl_olNXh9BPhOftPbsTvrO5SXyz46-3w_PQ'
                },
                { name: 'Aruna',
                  phone_number: '+919940257943',
                  blood_group: 'A+',
                  latitude: '13.760422',
                  longitude: '80.949583',
                  area: 'Tambaram'
                },
                { name: 'ShahrukhKhan',
                  phone_number: '+919965434554',
                  blood_group: 'O+',
                  latitude: '13.760422',
                  longitude: '80.949583',
                  area: 'Tambaram'
                }
            ])

BloodRequest.create([
                        {
                            user_id: 1,
                            blood_group: 'A+',
                            latitude: '13.060422',
                            longitude: '80.249583',
                            area: 'Velachery',
                            active: true
                        },
                        {
                            user_id: 1,
                            blood_group: 'A+',
                            latitude: '13.060422',
                            longitude: '80.249583',
                            area: 'Velachery',
                            active: false
                        }
                    ])

RequestResponseMapping.create([
                                  {
                                      blood_request_id: 1,
                                      user_id: 2
                                  },
                                  {
                                      blood_request_id: 1,
                                      user_id: 3
                                  }
                              ])