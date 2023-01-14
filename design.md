```mermaid

graph TD
    A[START] --> B(Presentation of options)
    B --> C{What type of practice?}
    C -->|NSDR| D{How long to practice for?}
    C -->|Silence| D{How long to practice for?}
    C -->|Relaxation| D{How long to practice for?}
    D -->|5 to 10 minutes| E{What type of background track?}
    D -->|30 minutes| E{What type of background track?}
    D -->|1 hour| E{What type of background track?}
    E -->|Silence| F{What do you want to do now?}
    E -->|Ambient Sounds| F{What do you want to do now?}
    E -->|Music| F{What do you want to do now?}
    F --> |Play| G(Play)
    F --> |Subscribe| H(Subscribe to newsletter)
    F --> |Start Again| B

    
