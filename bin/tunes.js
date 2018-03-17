let output = '';

if (Application('iTunes').running()) {
  const track = Application('iTunes').currentTrack;
  const artist = track.artist();
  const title = track.name();
  output = (`♫ ${artist} - ${title}`).substr(0, 50);
}

output;
