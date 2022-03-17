# Twitter-SwiftUI

Just a small replicate of Twitter. Clean Code + Unit Tests.

**Architecture:** MVVM-C. Because it's a small app. This architecture is much practical.

**Used Frameworks:** SwiftUI + Combine

On network layer, I've used protocol oriented approach. so that I can create mocked versions of network that returns dummy data.

To make SwiftUI Live Preview work, I also use a mock version of network that returns dummy data.

Unit tests are written to test successful data, network failure and mapping from DTO to model objects.

**How It Works?**

![](screen.gif) 
