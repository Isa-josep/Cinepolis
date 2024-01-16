
# Cinépolis

Aplicacion desarollada en Flutter, utiliza peticiones https a la Api de "themoviedb"  
## API Reference

#### Get Now Playing

```http
  GET /api/items
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `movie/now_playing` | `string` | **Required**. Your Themoviedb api key |

#### Get item

```http
  GET /api/items/${id}
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `id`      | `string` | **Required**. Id of item to fetch |




## Important !!!
put your api key in the .env.template file and rename the file to .env... if you don't do that the project will not work
