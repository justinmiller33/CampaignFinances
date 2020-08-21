from geopy.geocoders import Nominatim

geolocator = Nominatim(user_agent = "My Application")

street = "10 Forsyth St"
city = "Boston"
state = "MA"
postalcode = "02115"

#Creating dict of address
address = dict({"street":street, "city":city, "state":state, "postalcode":postalcode})

#Running through Nominatim's API
location = geolocator.geocode(address)

#Coords stored as tuple
coordinates = location[1]
