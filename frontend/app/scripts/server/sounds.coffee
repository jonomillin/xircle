define ->
  Sounds = {}

  sounds = ['cough1', 'cough2', 'cough3', 'cry1', 'cry2', 'cry3']
  Sounds[snd] = new Audio('/sounds/'+snd+'.mp3') for snd in sounds
  
  return Sounds
