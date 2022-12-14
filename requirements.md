## NSDR Online




|Author|Date|State|
|------|------|----|
|BigSpaces|December 2022|Draft| 


## Motivation

In the last few years there has been a resurgence in the interest for eastern spiritual practices. The covid lockdowns served as a catalizer for many to find new (or ancient) ways to find inner balance, once deprived from the usual western resources of going out, doing sports, going for a hike or meeting family and friends. Once binge watching Netflix fell short... what is there to do?

This resurgence in meditation and mindfulness is taking many flavors. On one end of the spectrum there is scientifically proven, lab-encapsulated, peer reviewed mindfulness techniques. On the other end of the spectrum we have the bells and whistles of spiritual claims and cosmic tunes which merge techniques with belief systems and sophisticated cosmologies. 

I find both extremes useful, true in their own way, though unnecessary for the average Joe who is having a hard time falling asleep after eight hours of zoom meetings and not getting out much.

This project is the answer to that problem: a series of practices and inner exercises that work simply because they do, with no bells and whistles, no sanskrit, and no yoga pants. A series of practices that are valid for all, from the rational materialist atheist, to the yogic aspirant, as well as the christian traditionalist.

This software aims to be a point of entry into serious meditative techniques. Some of these practices have passed the test of time for millennia, through their repeated delivery within their respective traditions, while others are being proven effective almost every day by the modern priesthood of the white coat in the church of the lab.

Devoid from their lingos and cosmologies, the internal procedures simply work, and are useful as a first step into the discipline of meditation and the path of inner mastery. 

This software brings what works to people who simply want to use it, not necessarily to study it.

## Context

This software is expected to work in most desktop computers through a standard web browser.

The aim is to deliver the same content in the form of a mobile app in the future (hopefully not too distant future). Liveview Native?

The current version of the software is devised as a proof of concept, a test to discover if there would be interest in developing the project further, into a paid app, in which users will be able to take meditation courses and journeys over the course of time.

The software will be able to craft personalised meditation practices based on user preferences and availability of time. It will do so through combining pre-recorded audio snippets and streaming them to the browser or app on user request.


## Use cases

### Choosing your meditation

STEP 1. A user visits the home page and three questions are asked related to the type of practice:

Which type of practice you want? At the moment the user can choose between...
  - Nidra (also called NSDR in the scientific community)
  - Antar (inner silence practice)
  - Body Scan (a relaxation technique for the body which helps with insomnia and retrains the nervous system to diffuse habitual tensions)

The user selects one by clicking at the option.

STEP 2. The next page automatically loads, which presents the second set of options, related to length:

How long do you have to practice?
  - Short (5 to 10 mins)
  - Medium (half an hour)
  - Long (an hour)

Upon selecting this option

STEP 3. The third page is shown, to choose background music or sound:

What type of background track do you prefer?
  - Silence
  - Music
  - Ambient 8D sounds (ocean, rain, forest sounds...)


STEP 4. The fourth (and final) page presents the user with:
  - A description of the practice, based on his choices.
  - A play button

The user will be able to stream his bespoke practice by clicking the play button.

Here is the sequence diagram for this use case

```mermaid
sequenceDiagram
    User->>+System: Start of use - Home page
    System-->>-User: Presentation of options - type of practice
    User->>+System: Type of practice chosen
    System-->>-User: Presentation of options - length of practice
    User->>+System: Length option chosen
    System-->>-User: Presentation of options - Background track
    User->>+System: Background track chosen
    System-->>-User: Description of practice + Option to play audio stream
    User->>+System: Press play
    System-->>-User: Audio stream starts
```
-----------------------------------------------
### Signing up for news and future updates

STEP 1: The user has completed choosing the type of meditative practice, which serves as a pre-qualifier of interest. Together with the option to play the meditation, a sign-up form is shown.

- "Provide your name and email and we will keep you posted of new practices and valuable information to help you make your mind your ally"

STEP 2: The user enters name, email, agrees with the terms and conditions, and clicks submit.

- The form validates the formatting of the data, as well as the agreement with the terms and conditions. If correct, a success message is shown. If incorrect, a message offering what needs to be corrected will be shown.

```mermaid
sequenceDiagram
    User->>+System: Play Page - Selection of meditation options completed
    System-->>-User: Sign Up form shown
    User->>+System: User provides name, email and agreement
    System-->>-User: Confirmation of signup or formatting not valid
```
-----------------------------------------------
### To be implemented - User accounts (Roadmap)

STEP 1: The website permanently shows the option to create an account in the header of the site.

- User is informed of the features that are accessed (and could be accessed in the future) by creating an account:
- - FREE: Practice calendar 
- - FREE: Statistics of practices
- - FREE: Discounted access to courses and transformational processes
- - FREE: Discounted access to one on one coaching
- - PAID MEMBERSHIP: Access to requests of personalized meditations
- - PAID MEMBERSHIP: Access to an exclusive mobile app
- - PAID MEMBERSHIP: Access to exclusive Q&A sessions with the creators 

-----
## Constraints

I will not develop an email sending system on my own, but will use an external email system (Mailchimp-like)
I am never going to publish private API keys on public forums

## Assumptions

I assume I have access to a server that can run Elixir and Phoenix
I assume everything will run locally during development
I assume I can deploy this on fly.io

Use Cases
Personas
Diagrams
Useful diagrams include:

Sequence
Activity
Causal Loop
State
Requirements Specification
Interfaces
Describe the interfaces:

The SW as a black box
Functional
Useability
Observability
Sustainability
Verification
This section is sometimes called (software or system) testing.
