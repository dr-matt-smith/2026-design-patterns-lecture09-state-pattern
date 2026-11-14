{
  "name": "The State Pattern",
  "description": "COMP Design Patterns · Week 9 State · The State Pattern (Head First Design Patterns ch. 10 terms): Context, State, ConcreteStates, delegation, and four UML variants.",
  "navigation": {
    "show": true,
    "style": "arrows-name",
    "position": "top-right",
    "showNumber": true
  },
  "sequenceArrows": {
    "show": true,
    "style": "dashed",
    "color": "#ffcc00",
    "alpha": 0.55
  },
  "nodes": [
    {
      "name": "The State Pattern",
      "x": 0,
      "y": 0,
      "text": "# OO Design Patterns:  Week 9(b) — The State Pattern\n\n\n## Learning outcomes\n\nYou will be able to:\n\n- **Describe**\n  - features of the state pattern\n  - the relationship between the **context** object and its **state** objects\n- **Explain**\n  - the 4 variations of the pattern <br>(interface vs abstract class, <br>and constructor parameters vs message parameters)\n\n<style scoped>section { font-size: 26px; }</style>\n\nRefer to:\n- chapter 10: **Head First Design Patterns**  (Freeman & Robson)\n"
    },
    {
      "name": "Gumball-Machine",
      "x": 240,
      "y": 0,
      "text": "# The problem: Mighty Gumball's machine\n\nThe gumball machine is a **state machine**:\n\n\n![](../diagrams/gumball_statechart_notitle.svg)\n\n- **States**: No Quarter / Has Quarter / Gumball Sold / Sold Out\n- **Events**: insert quarter / eject quarter / turn crank\n\n- **data** gumballs in machine `count`\n\n<style scoped>section { font-size: 24px; }</style>\n"
    },
    {
      "name": "Conditional-Code",
      "x": 480,
      "y": 0,
      "text": "# First attempt: state constants + IF-conditionals\n\n```typescript\nclass GumballMachine {\n    static readonly SOLD_OUT    = 0;    static readonly NO_QUARTER  = 1;\n    static readonly HAS_QUARTER = 2;    static readonly SOLD        = 3;\n    ...\n\n    insertQuarter(): void {\n        if (this.state === GumballMachine.HAS_QUARTER)      { /* \"already have one\" */ }\n\n        else if (this.state === GumballMachine.NO_QUARTER)  {\n            // change the current state to HAS_QUARTER\n            this.state = GumballMachine.HAS_QUARTER;\n        }\n\n        else if (this.state === GumballMachine.SOLD_OUT)    { /* \"sold out\" */ }\n        else if (this.state === GumballMachine.SOLD)        { /* \"please wait\" }\n    }\n\n    // ...same IF-ELSEs in ejectQuarter(), turnCrank(), dispense() ...\n}\n```\n\n- Then the **change request** arrives: the *1 in 10 \"Winner\" game* → a new state\n- Every action method must be edited — **not closed for modification**\n\n<style scoped>section { font-size: 24px; }</style>\n"
    },
    {
      "name": "Definition",
      "x": 480,
      "y": 180,
      "text": "# Definition: the State Pattern\n\n> **Allow an object to alter its behaviour when its internal state changes.<br>The object will appear to change its class.**\n>\n> — Gamma *et al.* (1995), the \"Gang of Four\"\n\n- **Alter its behaviour** \n  - the same call (`turnCrank()`) does different things depending on the current state object\n- **Appear to change its class** — to the client, the object behaves as if it were a different class; \n  - in a different state, it responds differently to messages it receives...\n  - really it is just **composition + delegation** to a different State object\n\n\n<style scoped>section { font-size: 26px; }</style>\n"
    },
    {
      "name": "State Pattern UML",
      "x": 120,
      "y": 120,
      "text": "# State Pattern: UML digram\n\n![w:645](../diagrams/state_v3_interface_cached_notitle.svg)\n\n\nThe **Context** is the object with the changing behaviour (e.g. Gumball machine)\n- its `state` variable is a reference to the current state object\n\nThe **Context** keeps a reference to its **current State** object and **delegates** each request\n- `handle()` illustrates an event, such as `insertQuarter()`, `turnCrank()` <br>- they’ll be one for each event the **Context** needs to handle\n"
    },
    {
      "name": "The-State-Pattern",
      "x": 0,
      "y": 180,
      "text": "# Implementing the State Pattern\n\nInstead of one large class full of `if`/`switch` statements on a state variable, <br>each state is written as its **own class**:\n\n```mermaid\n---\nconfig:\n  treeView:\n    showIcons: true\n    defaultIconPack: material-icon-theme\n    extensionIcons:\n      .ts: typescript\n---\ntreeView-beta\n    src/\n        states/\n            State.ts ## interface\n            HasQuarterState.ts ## state class\n            NoQuarterState.ts ## state class\n            SoldOutState.ts ## state class\n            SoldState.ts ## state class\n        GumballMachine.ts :::highlight ## context\n\n```\n\n\nThe **Context** is the object with the changing behaviour:\n- its `state` variable is a reference to the current state object\n\nThe **Context** keeps a reference to its **current State** object and **delegates** each request to it\n- so each `event()` messaged received by the  **Context** obejct (e.g. Gumball machine) becomes a simple call to `this.state.event(…)`\n"
    },
    {
      "name": "Example code",
      "x": 80,
      "y": 80,
      "text": "# some example State Pattern code <br>(for the Context object)\n\n```typescript\nexport class GumballMachine {\n  // -- an object for each state\n  private soldOutState: State;\n  private noQuarterState: State;\n  private hasQuarterState: State;\n  private soldState: State;\n\n  // -- the Gumball machine’s current state\n  private state: State;\n\n  // -- simply delegate event messages to the current state\n  public insertQuarter(): void {\n    this.state.insertQuarter();\n  }\n\n  public ejectQuarter(): void {\n    this.state.ejectQuarter();\n  }\n ..\n```"
    },
    {
      "name": "New-Design",
      "x": 240,
      "y": 180,
      "text": "# The new design: encapsulate what varies\n\nInstead of conditionals, **localise the behaviour of each state in its own class**\n\n1. Define a **State** interface with a method for **every action (event)** of the machine\n2. Write a **concrete State class** for each state of the machine\n3. The `GumballMachine` (the **Context**) **delegates** each action to its **current state** object\n\nDesign principles at work:\n\n- **Encapsulate what varies** — the state-specific behaviour\n- **Favour composition over inheritance** — the Context *has-a* State\n- **Open–Closed** — add `WinnerState` without rewriting every action method\n\n<style scoped>section { font-size: 26px; }</style>\n"
    },
    {
      "name": "avoid inheritance",
      "x": 160,
      "y": 160,
      "text": "\n**Favour composition over inheritance** \n\n- we do NOT want multiple **Context** objects (i.e. variations of the Gumball Machine)\n- (we want the Context *has-a* State: Gumball Machine contains State objects)\n\n# Avoid inheritance - do NOT do this\n\n![](../diagrams/gumball_inheritance.svg)"
    },
    {
      "name": "Transitions",
      "x": 240,
      "y": 360,
      "text": "# Who controls the state transitions?\n\nEach state decides when to tell the Context to change to another state\n\n- In the Gumball machine, the **concrete State classes** decide the next state\n  - `NoQuarterState.insertQuarter()` → `setState(getHasQuarterState())`\n  - adds **dependencies between state classes** — but the Context's getters\n    (`getHasQuarterState()`) keep them loose\n\n- NOTE: an alternative approach is for the **Context** to control transitions\n  - good when the transitions are **fixed**\n  - state classes stay simpler and independent of each other\n\n- Either way, the **state chart diagram is the specification** — each arrow becomes one line of code in one State class\n\n\n<style scoped>section { font-size: 26px; }</style>\n"
    },
    {
      "name": "Sharing-States",
      "x": 720,
      "y": 360,
      "text": "# Design choices for the State classes\n\n**Interface or abstract class?**\n\n- **interface** — each state implements every method\n- **abstract class** — default behaviour (e.g. \"inappropriate action\") and shared fields live in the superclass; states override only what they need\n\n**How does a State reach its Context?**\n\n- **cache a reference** — the Context is passed to each State's **constructor**\n- **pass it as a parameter** — each action method receives the Context: `insertQuarter(GumballMachine gm)`\n  - States then hold **no instance data** → they can be **shared** (e.g. static instances) between many Context objects\n\nSo there are 4 variants of the State Pattern architecture...\n\n<style scoped>section { font-size: 24px; }</style>\n"
    },
    {
      "name": "V1-Subclass-Cached",
      "x": 240,
      "y": 240,
      "text": "![bg fit](../diagrams/state_v1_abstract_cached.svg)"
    },
    {
      "name": "V1-Subclass-Cached - Gumball",
      "x": 240,
      "y": 540,
      "text": "![bg fit](../diagrams/gumball_v1_abstract_cached.svg)"
    },
    {
      "name": "V2-Subclass-Param",
      "x": 480,
      "y": 540,
      "text": "![bg fit](../diagrams/state_v2_abstract_param.svg)"
    },
    {
      "name": "V2-Subclass-Param gumball",
      "x": 280,
      "y": 280,
      "text": "![bg fit](../diagrams/gumball_v2_abstract_param.svg)"
    },
    {
      "name": "V3-Interface-Cached",
      "x": 720,
      "y": 540,
      "text": "![bg fit](../diagrams/state_v3_interface_cached.svg)"
    },
    {
      "name": "V3-Interface-Cached gumball",
      "x": 320,
      "y": 320,
      "text": "![bg fit](../diagrams/gumball_v3_interface_cached.svg)"
    },
    {
      "name": "V4-Interface-Param",
      "x": 960,
      "y": 540,
      "text": "![bg fit](../diagrams/state_v4_interface_param.svg)"
    },
    {
      "name": "V4-Interface-Param gumball",
      "x": 360,
      "y": 360,
      "text": "![bg fit](../diagrams/gumball_v4_interface_param.svg)"
    },
    {
      "name": "Variants-Compared",
      "x": 1200,
      "y": 540,
      "text": "# The four variants compared\n\n| | Context reference **cached** (constructor) | Context **passed** as event parameter |\n|---|---|---|\n| **Abstract superclass** | **V1** — field + constructor written once; default behaviour inherited; states per machine | **V2** — default behaviour inherited; stateless, **shareable** states |\n| **Interface** | **V3** — *Head First* version; field + constructor repeated in each state; states per machine | **V4** — stateless, **shareable**; every method implemented in every state |\n\n- **Cached**: simpler method signatures\n  - but each Context needs **its own** State objects\n- **Passed**: longer signatures \n  — but states can be **shared** between Contexts\n- **Superclass**: less duplication \n  — but uses up the single inheritance slot (Java / C#)\n\n<style scoped>section { font-size: 22px; }</style>\n"
    },
    {
      "name": "see README",
      "x": 40,
      "y": 40,
      "text": "\n\n\nNOTE:\nsee the README of this project, for more discussion about the 4 variants for the Gumball machine\n\nthe following slides show the variants for the Gumball machine example\n![](../images/readme_screenshot.webp)\n\n"
    },
    {
      "name": "implementing state transition",
      "x": 400,
      "y": 400,
      "text": "# how system transitions to a new state\n\nFor this module, we’ll use the following straightforward approach for implementation of state transitions:\n\n  - the **context** creates an object of each state, with ‘getters’\n  - the **state** wishing to change the system uses the getter for the new state when invoking `setState()`:\n\n"
    },
    {
      "name": "context code",
      "x": 480,
      "y": 480,
      "text": "the **context** creates an object of each state, with ‘getters’:\n```typescript  \n// GumballMachine.ts\nexport class GumballMachine \n{\n  private soldOutState: State;\n  private noQuarterState: State;\n  private hasQuarterState: State;\n  private soldState: State;\n\n  public getSoldOutState(): State { return this.soldOutState; }\n  public getNoQuarterState(): State { return this.noQuarterState; }\n```"
    },
    {
      "name": "state code",
      "x": 560,
      "y": 560,
      "text": "the **state** wishing to cause a system state transition uses the getter for the new state when invoking `setState()` on the **context** object:\n\n```typescript  \n// NoQuarterState.ts\npublic insertQuarter(): void {\n  console.log(\"You inserted a quarter\");\n  this.gumballMachine.setState(this.gumballMachine.getHasQuarterState());\n}\n```\n\nor we could break it down further:\n\n```typescript  \n// NoQuarterState.ts\npublic insertQuarter(): void {\n  console.log(\"You inserted a quarter\");\n  const newState = this.gumballMachine.getHasQuarterState();\n  this.gumballMachine.setState(newState);\n}\n```\n"
    },
    {
      "name": "alternative approach to state transition",
      "x": 440,
      "y": 440,
      "text": "# alterntative: create new state when time to transition...\n\nan alternative approach is for **new** state objects to be created when there is to be a transition from one state to another\n  - e.g. \n  ```typescript\n  // NoQuarterState.ts\n  insertQuarter(): void {\n      this.machine.setState(new HasQuarterState(this.machine));\n  }\n  ```\n\nbut we won’t explore this particular approach in this module ...\n"
    },
    {
      "name": "Summary",
      "x": 960,
      "y": 360,
      "text": "# Summary\n\n- State Pattern lets an object have **many different behaviours** that depend on its **internal state**\n- Each state represented as a **class** — behaviour is **localised**, conditionals disappear\n- The **Context delegates** to the State object it is **composed with**\n- New states (e.g. `WinnerState`) mean **new classes**, not edits everywhere \n  — **open for extension**\n- Transitions may be controlled by the **State classes** or the **Context**\n- Trade-off: typically **more classes** in the design\n- **State vs Strategy** — same class diagram, different **intent**\n\n<style scoped>section { font-size: 26px; }</style>\n"
    },
    {
      "name": "Ref-HFDP",
      "x": 240,
      "y": 720,
      "text": "# References\n\n- Freeman, E. & Robson, E. (2020) *Head First Design Patterns*, 2nd edn. O'Reilly — **Chapter 10: The State Pattern**\n\n- Gamma, E., Helm, R., Johnson, R. & Vlissides, J. (1995) *Design Patterns: Elements of Reusable Object-Oriented Software*. Addison-Wesley — **State**, p. 305\n\n- Refactoring Guru State Pattern (visited November 2026):\n  - <https://refactoring.guru/design-patterns/state>\n\n<style scoped>section { font-size: 26px; }</style>\n"
    }
  ]
}
