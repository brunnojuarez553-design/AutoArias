# AutoArias — demo web + panel de inventario

## Abrir la demo

1. Abrí `index.html` para ver el sitio público.
2. Abrí `admin.html` para gestionar el inventario.
3. La demo usa `localStorage`: lo que cargues desde el panel aparece en el sitio público en ese mismo navegador.

## Datos configurados

- Concesionaria: **AutoArias**
- Ciudad: **Ushuaia, Tierra del Fuego, Argentina**
- Dirección: **Hipólito Yrigoyen 2383, V9410 Ushuaia**
- WhatsApp / teléfono: **+54 9 2901 55-3973**
- Email: **autoarias.info@gmail.com**
- Instagram: **@auto_arias**

## Cambios realizados

- Se eliminó toda la identidad y el inventario de E. Aquino Auto Import.
- Se quitaron fotos, fondos fotográficos, video y logo anteriores.
- El inventario inicial queda vacío para cargar vehículos reales.
- Se reemplazaron “trade-in”, “millaje” y “pronto pago” por **permuta**, **kilometraje** y **anticipo**.
- Los precios del demo quedaron configurados en **pesos argentinos (ARS)**.
- El mapa y los datos de contacto apuntan a AutoArias en Ushuaia.
- La marca se muestra temporalmente como wordmark de texto `AUTOARIAS` hasta que agregues el logo final.

## Fotos nuevas

En el panel, cada vehículo permite pegar una o varias URLs de imágenes, una por línea. La primera se usa como portada. Mientras no haya fotos, se muestra un placeholder local neutro.

## Próxima etapa profesional

1. Crear proyecto en Supabase.
2. Ejecutar `supabase-schema.sql`.
3. Configurar autenticación del administrador.
4. Reemplazar `localStorage` por consultas a Supabase.
5. Conectar Cloudinary o Supabase Storage para subir fotos directamente desde la galería del teléfono.
6. Publicar en Vercel.
7. Conectar dominio, Analytics, Search Console y WhatsApp.

> El simulador de financiación sigue siendo demostrativo. Antes de publicar, reemplazá la tasa de referencia por las condiciones reales de AutoArias.
