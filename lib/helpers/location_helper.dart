String publicTokenKey =
    'pk.eyJ1IjoicnVndmVka3V0ZSIsImEiOiJja3dnNzVlNWQwbHcwMnduc215emljcjNjIn0.pl_U8H2QwkKfbRLUX52Gxg';



class LocationHelper { static String generatePreviewImageUrl({double latitude, double longitude})
 {  return 'https://api.mapbox.com/styles/v1/mapbox/streets-v11/static/pin-l($longitude,$latitude)/$longitude,$latitude,14.25,0,0/600x300?access_token=$publicTokenKey';   } }