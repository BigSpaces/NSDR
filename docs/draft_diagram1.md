Diagram of use case for the requirements.md file. 


```
sequenceDiagram
    User->>+System: I want to meditate today
    System-->>-User: What type of practice would you like?
    User->>+System: I would like (A/B/C) practice
    System-->>-User: How long do you want your practice to be?
    User->>+System: I would like a (short/medium/long) practice
    System-->>-User: What type of background track would you like?
    User->>+System: I would like (music/ambient/silence)
    System-->>-User: Here is your practice (description). Press play!
    User->>+System: I just pressed play
    System-->>-User: I start to play your customised practice. Enjoy!

    User1->>+System1: Start of use - Home page
    System1-->>-User1: Presentation of options - type of practice
    User1->>+System1: Type of practice chosen
    System1-->>-User1: Presentation of options - length of practice
    User1->>+System1: Length option chosen
    System1-->>-User1: Presentation of options - Background track
    User1->>+System1: Background track chosen
    System1-->>-User1: Description of practice + Option to play audio stream
    User1->>+System1: Press play
    System1-->>-User1: Audio stream starts
 ```
