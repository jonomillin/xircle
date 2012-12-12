define ->
  Sounds = {}

  sounds = ['cough1', 'cough2', 'cough3', 'cry1', 'cry2', 'cry3', 'music', 'jingle', 'silent8']
  for snd in sounds
    do (snd) ->
      Sounds[snd] = new Audio('/sounds/'+snd+'.mp3')
      Sounds[snd].play = ->
        unless Sounds.disable
          Audio.prototype.play.call(@)

  
  return Sounds
