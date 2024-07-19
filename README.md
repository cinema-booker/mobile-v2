<div align="center">
  <a>
    <img 
      src="https://cdn3d.iconscout.com/3d/premium/thumb/video-application-9582616-7746822.png?f=webp"
      alt="Logo" 
      height="100" />
  </a>
  <h3 align="center"> Cinema Booker - Flutter App </h3>
  <p align="center">
     Cinema Booker App using flutter and Dart
  </p>
</div>



## Environment variable :

We are using 3 Api in this project : 

[TMDB](https://developer.themoviedb.org/reference/intro/getting-started) :  Used to get movie informations ([API Key position](https://github.com/cinema-booker/mobile-v2/blob/46d6537e4686105a02fe7c1a85218b74a490063f/lib/services/movie_service.dart#L5)) 

[Google Places](https://developers.google.com/maps/documentation/places/web-service/overview?hl=fr) : Used for locations ([API Key position](https://github.com/cinema-booker/mobile-v2/blob/46d6537e4686105a02fe7c1a85218b74a490063f/lib/services/places_service.dart#L7)) 


[STRIPE](https://docs.stripe.com/api) : Used for payments ([API Key position](https://github.com/cinema-booker/mobile-v2/blob/46d6537e4686105a02fe7c1a85218b74a490063f/lib/services/stripe_service.dart#L8)) 


## Project install

```bash
clone project 
cd api
flutter pub get
flutter run
```
