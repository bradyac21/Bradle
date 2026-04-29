### BRADLE

<div align="center">
<img width="300" height="635" alt="Bradle Landing Landing Page" src="https://github.com/user-attachments/assets/aee4935f-529f-4e33-83b6-67a32bca1fa4" />
</div>

<br>

Part of my morning routine is to play the day's Wordle challenge. After I successfully guess the word (or fail), I send my Wordle into a group chat where I compare results with friends. Turns out, this is a pretty common practice. Whenever the word is notably tricky, something like "NYMPH" or "SISSY," I see many lighthearted complaints on my social media pages. I remember playing this game when it initially came out, before it was bought by the New York Times and was visually overhauled. That was early in my college career and I still play to this day. 

As I sought to develop my iOS app development skills, it became clear to me that the best way to learn the paradigms and functionalities of the iOS suite was to build an end-to-end app. There's only so much you can do with watching tutorials and building isolated views and view models. The only issue was the idea to get it started. Then it hit me! Wordle is simple enough to be approachable, but is a fully-featured and professionally designed app that is used daily by millions of people around the world. Why don't I build it from scratch?

That's exactly what I did. Starting from the template "Hello, World!" view, I built from the ground up all the screens, logic, animations, and navigation for the app to function. The various requirements for the app enabled me to explore all facets of iOS development. 
- injected `AppManager` into the SwiftUI Environment to mange game logic, alerts, and navigation
- Used `PhaseAnimator` and `.animation` to match the visually stimulating experience of the official app
- Built a `ColorManager` to handle dynamic theming across light mode, dark mode, and accessibility color settings which persisted across sessions using UserDefaults

Through the course of development, I learned most about the animation system which I had never interacted with before. Knowing what the app played like before and after animation locks in the importance of a captivating and immersive user experience. The process of designing a `ColorManager` also proved edifying, as it was much more difficult than I initially believed to manage light and dark modes in concert with accessibility settings. Dictionaries proved extremely useful here. Most importantly I learned the skill of app organization. It's difficult to get everything where it needs to go and is essential that the fundamental app infrastructure is intuitive and scalable; there's nothing worse than taking a break from a project and having to relearn the entire app when you return.

<img width="1233" height="717" alt="World Samples" src="https://github.com/user-attachments/assets/ec4073d9-500d-431d-aaf8-6cd3a6677619" />

