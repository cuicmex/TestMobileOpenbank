# Test Mobile - Openbank
## Repositorio con el proyecto de prueba personajes Marvel

El proyecto se basa en la arquitectura Clean Swift (VIP). 

Por otra parte, la idea fue seguir e implementar diferentes técnicas para la creación de elementos UI, entre ellos storyboard, vistas mediante archivos xib y creación por programa. En cuanto a funcionalidad, aunque reducida a la consulta de los personajes y su detalle, la intención fue cubrirlo a fin de presentar una aplicación factible de ser publicada. No obstante lo dicho, y por cuestiones de tiempo, no se agrego el framework de Firebase para analytics y push notifications.

La aplicación considera localización Inglés/Español para las cadenas de texto, así como los paquetes SPM Alamofire para el networking, Lottie para la animación del indicador de actividad, y SDWebImage para el fetch de las imágenes.

Igualmente se aplicaron diferentes niveles de herencia para optimizar el reaprovechamiento de código en un supuesto futuro.

También se agregaron tests unitarios base para los workers de networking.
