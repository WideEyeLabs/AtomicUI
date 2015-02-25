AtomicUI is a simple interface object library.

####Installation
Using [Carthage](https://github.com/Carthage/Carthage) add
```shell
github "wideeyelabs/AtomicUI"
```
to your Cartfile

### AtomSlideController


```objective-c
#import <AtomSlideController.h>

// ..
// ..

id appDel = [[UIApplication sharedApplication] delegate];
AtomSlideController *slide = [appDel slideController];
[slide closeSlide];

[self performAsyncRequest:^()completion {
  [slide stopIndicator];
}];
```
