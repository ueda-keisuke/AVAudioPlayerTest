# AVAudioPlayerTest

## What is this?
This is a sample that demonstrates AVAudioPlayer in iOS 9. Since I had a trouble with recording, I asked on stackoverflow. This project was used for explaining my situation. 

The first commit code worked on simulator. The app could record audio and play the recorded audio. However I realized the app could not play the audio on a real iPad.

The cause was a misuse of AudioSession. I hope this code helps someone who has the same issue.
