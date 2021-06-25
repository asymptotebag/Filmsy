# Project 2 - *Filmsy*

**Filmsy** is a movies app using the [The Movie Database API](http://docs.themoviedb.apiary.io/#).

Time spent: **15** hours spent in total

## User Stories

The following **required** functionality is complete:

- [x] User sees an app icon on the home screen and a styled launch screen.
- [x] User can view a list of movies currently playing in theaters from The Movie Database.
- [x] Poster images are loaded using the UIImageView category in the AFNetworking library.
- [x] User sees a loading state while waiting for the movies API.
- [x] User can pull to refresh the movie list.
- [x] User sees an error message when there's a networking error.
- [x] User can tap a tab bar button to view a grid layout of Movie Posters using a CollectionView.

The following **optional** features are implemented:

- [x] User can tap a poster in the collection view to see a detail screen of that movie
- [x] User can search for a movie.
- [x] All images fade in as they are loading. Images do not fade in if they are already cached, UNLESS they are part of the CollectionView of posters. I found that the interface was much smoother if all posters faded in in the grid view, regardless of cache status.
- [ ] User can view the large movie poster by tapping on a cell.
- [ ] For the large poster, load the low resolution image first and then switch to the high resolution image when complete.
- [x] Customize the selection effect of the cell. Not a big change, but I've made it a subtler gray.
- [ ] Customize the navigation bar.
- [x] Customize the UI.
- [x] \*User can view the app on various device sizes and orientations. Somewhat—I didn't have enough time to implement this for the movie details screen or the CollectionView screen, but the launch screen and TableView of movies now both adapt to screen size/orientation.
- [x] Run your app on a real device.

The following **additional** features are implemented:

- [ ] List anything else that you can get done to improve the app functionality!

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. There seems to be a lot of reused code for actions done multiple times for different objects and different view controllers. For example, in order to make all images fade in as they loaded, I needed to copy-paste a sizeable chunk of code whenever an image was displayed. It was performing nearly the exact same operation every time. I feel like there is probably a cleaner way of doing this, perhaps by extracting out the fade-in code as a separate method, but I wasn't quite familiar enough with Objective-C to try.
2. I assume that I'm just not well-versed enough in Auto Layout to know how to do this, but I really wonder if there is an easy way to set the width/height of an object to be a certain percentage of the device screen's width and height. Oftentimes I don't want a fixed height or width like the constraint warnings tell me to create, but a dynamic one so that users see the same-sized content proportional to their own device screen. I know this technique is simple in CSS with web design, so I was disappointed that it didn't seem to be a readily available option in the constraint menu.

## Video Walkthrough

Here's a walkthrough of implemented user stories. The gifs showcase, in order:

1. App icon, launch screen, Now Playing list, pull to refresh, CollectionView of movie posters, movie details screen visible from both TableView and CollectionView, customized cell selection effect, customized UI in the details screen, and images fading in (gif is sped up 2x to conserve file size, so fade-ins are no longer obvious).
2. Search functionality, which is case-insensitive.
3. Better view of the loading state while waiting for movies API. (This was recorded before I made images fade in.)
4. Offline error message. Here Filmsy is being run and recorded on a real iPhone 11.
5. Filmsy being run on an iPhone 12 mini, in both landscape and portrait orientation.


![filmsy_main](https://user-images.githubusercontent.com/43052066/123343636-20269000-d520-11eb-994c-2ac1a971a0a4.gif)
![filmsy_search](https://user-images.githubusercontent.com/43052066/123343644-27e63480-d520-11eb-95e0-e74b060e2fa7.gif)
![filmsy_load](https://user-images.githubusercontent.com/43052066/123343650-2a488e80-d520-11eb-9ede-032a7c0b8722.gif)

![filmsy_offline](https://user-images.githubusercontent.com/43052066/123343656-2caae880-d520-11eb-9139-078ff2628f24.gif)
![filmsy_flipper](https://user-images.githubusercontent.com/43052066/123472907-d1cbcc80-d5c5-11eb-9f9a-0a36e039919d.gif)


## Notes

Describe any challenges encountered while building the app.
1. It was a bit tricky to figure out how to implement the network connectivity error message. I saw some third-party reachability solutions, as well as some deprecated reachability sample code from Apple, but I also read on Stack Overflow that these reachability solutions gave various errors to a lot of users. I ended up using the URL request handler to detect the specific error code for being unable to connect to the Internet, and give an error message if that error code was detected. This method worked when I put my phone on Airplane Mode and tried to load the movies.
2. Getting Auto Layout to work in certain screens of my app was very satisfying, since I had storyboarded the UI on an iPhone 11 screen (and thus could view it properly on my personal iPhone 11), so before Auto Layout my app looked incredibly ugly on my work phone, which was disheartening. However, in other views Auto Layout was giving me a lot of trouble, particularly in the ScrollView in the movie details screen. I read on Stack Overflow that I should create a UIView inside of the ScrollView, and then place all items inside of that UIView; however, for some reason the backdropView refused to be placed inside the UIView. 
3. I had to refactor a good amount of code to implement the searching function, but I didn't run into major trouble while doing so.

## Credits

List an 3rd party libraries, icons, graphics, or other assets you used in your app.

- [AFNetworking](https://github.com/AFNetworking/AFNetworking) - networking task library

## License

    Copyright 2021 Emily Jiang

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
