AtomicUI is a simple interface object library built on top of [Masonry](https://github.com/cloudkite/Masonry).

## How To Get Started

AtomicUI can be installed via CocoaPods by adding "pod 'AtomicUI', git: 'Update URL after repo is created'" to your Podfile.

### AtomSlideController


```objective-c
#import <AtomSlideController.h>

// ..
// ..

id appDel = [[UIApplication sharedApplication] delegate];
AtomSlideController *slide = [appDel slideController];
[slide closeSlide];
[slide startIndicator];

[self performAsyncRequest:^()completion {
  [slide stopIndicator];
}];
```
