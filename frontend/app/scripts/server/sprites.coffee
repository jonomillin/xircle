define ['easel'], (easel) ->
  
  Sprites = {}

  sprites = ['water', 'ice', 'snowman', 'santa', 'rudolf', 'tree', 'robin', 'baby', 'elf']
  Sprites[img] = new easel.Bitmap("/images/#{img}.png") for img in sprites

  Sprites
