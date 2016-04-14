# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# nation_ids
Nation.create(name: 'Colombia')
Nation.create(name: 'Brasil')
Nation.create(name: 'Venezuela')

User.create(
    email: 'lf.mendivelso10@uniandes.edu.co',
    name: 'Luis Felipe',
    last_name: 'Mendivelso Osorio',
    documentId: '11111111',
    phone: '3131313131',
    cellphone: '123123123123',
    nation_id: 1
)

User.create(
    email: 'd.jimenez13@uniandes.edu.co',
    name: 'David Thomas',
    last_name: 'Jimenez',
    documentId: '11111111',
    phone: '3131313131',
    cellphone: '123123123123',
    nation_id: 2
)
User.create(
    email: 's.rios11@uniandes.edu.co',
    name: 'Sergio',
    last_name: 'Rios',
    documentId: '11111111',
    phone: '3131313131',
    cellphone: '123123123123',
    nation_id: 3
)
User.create(
    email: 'd.espinal10@uniandes.edu.co',
    name: 'David',
    last_name: 'Espinal',
    documentId: '11111111',
    phone: '3131313131',
    cellphone: '123123123123',
    nation_id: 1
)

Pet.create(
    user_id: 1,
    name: 'Chimuela',
    gender: 'F',
    description: 'Gata de Color Negra con Machas Blancas',
    breed: 'Mestiza',
    birthDate: Date.strptime('2014/06/26', '%Y/%m/%d'),
    petStatus: 'OK'
)
Pet.create(
    user_id: 2,
    name: 'Nao',
    gender: 'M',
    description: 'Perro de Color Negra con Machas Blancas',
    breed: 'Gran Danes',
    birthDate: Date.strptime('2010/06/26', '%Y/%m/%d'),
    petStatus: 'OK'
)
Pet.create(
    user_id: 3,
    name: 'DinDingo',
    gender: 'M',
    description: 'Perro de color Dorado',
    breed: 'Labrador',
    birthDate: Date.strptime('2014/06/1', '%Y/%m/%d'),
    petStatus: 'OK'
)
Pet.create(
    user_id: 4,
    name: 'Pinky',
    gender: 'M',
    description: 'Pequeño de Color negro',
    breed: 'Pincher',
    birthDate: Date.strptime('2013/03/26', '%Y/%m/%d'),
    petStatus: 'OK'
)

PetCondition.create(
    pet_id: 1,
    ownerEmail: 'lf.mendivelso10@uniandes.edu.co',
    latitude: 0,
    longitude: 0,
    breathingFrequency: 0,
    heartFrequency: 0,
    systolicPressure: 0,
    diastolicPressure: 0,
    temperature: 0
)
PetCondition.create(
    pet_id: 2,
    ownerEmail: 'd.jimenez13@uniandes.edu.co',
    latitude: 0,
    longitude: 0,
    breathingFrequency: 0,
    heartFrequency: 0,
    systolicPressure: 0,
    diastolicPressure: 0,
    temperature: 0
)
PetCondition.create(
    pet_id: 3,
    ownerEmail: 's.rios11@uniandes.edu.co',
    latitude: 0,
    longitude: 0,
    breathingFrequency: 0,
    heartFrequency: 0,
    systolicPressure: 0,
    diastolicPressure: 0,
    temperature: 0
)
PetCondition.create(
    pet_id: 4,
    ownerEmail: 'd.espinal10@uniandes.edu.co',
    latitude: 0,
    longitude: 0,
    breathingFrequency: 0,
    heartFrequency: 0,
    systolicPressure: 0,
    diastolicPressure: 0,
    temperature: 0
)

Collar.create(pet_id: 1, collarId: 'AASASAAASA1', collarReference: 'KDI123', description: 'none')
Collar.create(pet_id: 2, collarId: 'AASASAAASA2', collarReference: 'KDI123', description: 'none')
Collar.create(pet_id: 3, collarId: 'AASASAAASA3', collarReference: 'KDI123', description: 'none')
Collar.create(pet_id: 4, collarId: 'AASASAAASA4', collarReference: 'KDI123', description: 'none')

SafeZone.create(pet_id: 1, latitude: 4.648681, longitude: -74.108907, radius: 100)
SafeZone.create(pet_id: 2, latitude: 4.662522, longitude: -74.134700, radius: 100)
SafeZone.create(pet_id: 3, latitude: 4.602816, longitude: -74.065038, radius: 100)
SafeZone.create(pet_id: 4, latitude: 4.601928, longitude: -74.066014, radius: 100)

