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
      "name": "Title",
      "x": 0,
      "y": 0,
      "text": "# The State Pattern\n\n### COMP Design Patterns · Week 9 — State (lecture 2)\n\n<!-- Terminology follows Head First Design Patterns, ch. 10 (Freeman & Robson). -->\n"
    },
    {
      "name": "1-Gumball-Machine",
      "x": 240,
      "y": 0,
      "text": "# 1. The problem: Mighty Gumball's machine\n\nThe gumball machine is a **state machine** before it is any code:\n\n```mermaid\nstateDiagram-v2\n    direction LR\n    [*] --> NoQuarter\n    NoQuarter --> HasQuarter : insertQuarter()\n    HasQuarter --> NoQuarter : ejectQuarter()\n    HasQuarter --> GumballSold : turnCrank()\n    GumballSold --> NoQuarter : dispense() [gumballs > 0]\n    GumballSold --> OutOfGumballs : dispense() [gumballs = 0]\n```\n\n- **States**: No Quarter · Has Quarter · Gumball Sold · Out of Gumballs\n- **Actions** (the events): insert quarter · eject quarter · turn crank · dispense\n\n<style scoped>section { font-size: 24px; }</style>\n"
    },
    {
      "name": "2-Conditional-Code",
      "x": 480,
      "y": 0,
      "text": "# 2. First attempt: state constants + conditionals\n\n```java\nfinal static int SOLD_OUT = 0, NO_QUARTER = 1,\n                 HAS_QUARTER = 2, SOLD = 3;\nint state = SOLD_OUT;\n\npublic void insertQuarter() {\n    if (state == HAS_QUARTER)      { /* \"already have one\" */ }\n    else if (state == NO_QUARTER)  { state = HAS_QUARTER; }\n    else if (state == SOLD_OUT)    { /* \"sold out\" */ }\n    else if (state == SOLD)        { /* \"please wait\" */ }\n}\n// ...same if/else ladder in ejectQuarter(), turnCrank(), dispense()\n```\n\n- Then the **change request** arrives: the *1 in 10 \"Winner\" game* → a new state\n- Every action method must be edited — **not closed for modification**\n\n<style scoped>section { font-size: 24px; }</style>\n"
    },
    {
      "name": "The-State-Pattern",
      "x": 0,
      "y": 180,
      "text": "# The State Pattern\n"
    },
    {
      "name": "3-New-Design",
      "x": 240,
      "y": 180,
      "text": "# 3. The new design: encapsulate what varies\n\nInstead of conditionals, **localise the behaviour of each state in its own class**\n\n1. Define a **State** interface with a method for **every action** of the machine\n2. Write a **concrete State class** for each state of the machine\n3. The `GumballMachine` (the **Context**) **delegates** each action to its **current state** object\n\nDesign principles at work:\n\n- **Encapsulate what varies** — the state-specific behaviour\n- **Favour composition over inheritance** — the Context *has-a* State\n- **Open–Closed** — add `WinnerState` without rewriting every action method\n\n<style scoped>section { font-size: 26px; }</style>\n"
    },
    {
      "name": "4-Definition",
      "x": 480,
      "y": 180,
      "text": "# 4. Definition: the State Pattern\n\n> **Allow an object to alter its behaviour when its internal state changes.<br>The object will appear to change its class.**\n>\n> — Gamma *et al.* (1995), the \"Gang of Four\"\n\n- **Alter its behaviour** — the same call (`turnCrank()`) does different things depending on the current state object\n- **Appear to change its class** — to the client, the object behaves as if it were a different class; really it is just **composition + delegation** to a different State object\n\n<style scoped>section { font-size: 26px; }</style>\n"
    },
    {
      "name": "5-Class-Diagram",
      "x": 720,
      "y": 180,
      "text": "# 5. The State Pattern class diagram\n\n```nomnoml\n#direction: right\n#spacing: 50\n[Context|state: State|request()]\n[<interface>«interface»;State|handle()]\n[ConcreteStateA|handle()]\n[ConcreteStateB|handle()]\n[Context] o-> [<interface>«interface»;State]\n[ConcreteStateA] --:> [<interface>«interface»;State]\n[ConcreteStateB] --:> [<interface>«interface»;State]\n[<note>request() calls state.handle()] -- [Context]\n```\n\n- **Context** — the class with internal states (`GumballMachine`)\n- **State** — common interface for all concrete states\n- **ConcreteStates** — handle requests from the Context; each gives its own behaviour\n\n<style scoped>section { font-size: 24px; }</style>\n"
    },
    {
      "name": "6-Delegation-Code",
      "x": 960,
      "y": 180,
      "text": "# 6. The Context delegates to its current state\n\n```java\npublic class GumballMachine {\n    State soldOutState, noQuarterState, hasQuarterState, soldState;\n    State state;          // the CURRENT state\n    int count = 0;\n\n    public void insertQuarter() { state.insertQuarter(); }\n    public void ejectQuarter()  { state.ejectQuarter();  }\n    public void turnCrank()     { state.turnCrank(); state.dispense(); }\n\n    void setState(State state)  { this.state = state; }\n    State getHasQuarterState()  { return hasQuarterState; }  // ... etc.\n}\n\npublic class NoQuarterState implements State {\n    public void insertQuarter() {\n        gumballMachine.setState(gumballMachine.getHasQuarterState());\n    }\n    public void ejectQuarter() { /* \"You haven't inserted a quarter\" */ }\n}\n```\n\n<style scoped>section { font-size: 22px; }</style>\n"
    },
    {
      "name": "Discussion",
      "x": 0,
      "y": 360,
      "text": "# Discussion\n"
    },
    {
      "name": "7-Transitions",
      "x": 240,
      "y": 360,
      "text": "# 7. Who controls the state transitions?\n\n- In the Gumball machine, the **concrete State classes** decide the next state\n  - `NoQuarterState.insertQuarter()` → `setState(getHasQuarterState())`\n  - adds **dependencies between state classes** — but the Context's getters\n    (`getHasQuarterState()`) keep them loose\n- Alternatively the **Context** can control transitions\n  - good when the transitions are **fixed**\n  - state classes stay simpler and independent of each other\n- Either way, the **state chart diagram is the specification** — each arrow becomes one line of code in one State class\n\n<style scoped>section { font-size: 26px; }</style>\n"
    },
    {
      "name": "8-State-vs-Strategy",
      "x": 480,
      "y": 360,
      "text": "# 8. State vs Strategy: same diagram, different intent\n\n| | **Strategy** | **State** |\n|---|---|---|\n| Class diagram | Context composed with an interface | *identical* |\n| Who picks the object? | usually the **client** configures the Context | changes **internally**, as the Context runs |\n| Does it change? | rarely — chosen once, a flexible alternative to subclassing | constantly — the State objects swap as events arrive |\n| Client awareness | client knows the strategies | client typically **unaware** of the states |\n| Intent | interchangeable **algorithm** | alternative to **lots of conditionals** in the Context |\n\n<style scoped>section { font-size: 22px; }</style>\n"
    },
    {
      "name": "9-Sharing-States",
      "x": 720,
      "y": 360,
      "text": "# 9. Design choices for the State classes\n\n**Interface or abstract class?**\n\n- **interface** — each state implements every method\n- **abstract class** — default behaviour (e.g. \"inappropriate action\") and shared fields live in the superclass; states override only what they need\n\n**How does a State reach its Context?**\n\n- **cache a reference** — the Context is passed to each State's **constructor**\n- **pass it as a parameter** — each action method receives the Context: `insertQuarter(GumballMachine gm)`\n  - States then hold **no instance data** → they can be **shared** (e.g. static instances) between many Context objects\n\n→ the four UML variants that follow\n\n<style scoped>section { font-size: 24px; }</style>\n"
    },
    {
      "name": "10-Summary",
      "x": 960,
      "y": 360,
      "text": "# 10. Summary\n\n- The State Pattern lets an object have **many different behaviours** that depend on its **internal state**\n- Each state is represented as a **class** — behaviour is **localised**, conditionals disappear\n- The **Context delegates** to the State object it is **composed with**\n- New states (e.g. `WinnerState`) mean **new classes**, not edits everywhere — **open for extension**\n- Transitions may be controlled by the **State classes** or the **Context**\n- Trade-off: typically **more classes** in the design\n- **State vs Strategy** — same class diagram, different **intent**\n\n<style scoped>section { font-size: 26px; }</style>\n"
    },
    {
      "name": "UML-Variants",
      "x": 0,
      "y": 540,
      "text": "# Four UML variants\n\n### abstract superclass or interface? <br>cached Context reference or Context passed as a parameter?\n"
    },
    {
      "name": "V1-Subclass-Cached",
      "x": 240,
      "y": 540,
      "text": "# Variant 1 — abstract superclass, Context cached in constructor\n\n```nomnoml\n#direction: down\n#spacing: 30\n#padding: 6\n#fontSize: 11\n[GumballMachine|count: int;state: State;noQuarterState: State;hasQuarterState: State;soldState: State;soldOutState: State|insertQuarter();ejectQuarter();turnCrank();setState(s: State);releaseBall()]\n[<abstract>«abstract»;State|# gumballMachine: GumballMachine|+ State(gm: GumballMachine);+ insertQuarter();+ ejectQuarter();+ turnCrank();+ dispense()]\n[GumballMachine] o-> 4 [<abstract>«abstract»;State]\n[<abstract>«abstract»;State] -> [GumballMachine]\n[NoQuarterState] -:> [<abstract>«abstract»;State]\n[HasQuarterState] -:> [<abstract>«abstract»;State]\n[SoldState] -:> [<abstract>«abstract»;State]\n[SoldOutState] -:> [<abstract>«abstract»;State]\n```\n\n- the **protected** field and constructor are written **once**, in the superclass\n- superclass gives default \"inappropriate action\" behaviour; subclasses override\n- `new NoQuarterState(this)` — one set of states **per machine**\n\n<style scoped>section { font-size: 20px; }</style>\n"
    },
    {
      "name": "V2-Subclass-Param",
      "x": 480,
      "y": 540,
      "text": "# Variant 2 — abstract superclass, Context passed to each event\n\n```nomnoml\n#direction: down\n#spacing: 30\n#padding: 6\n#fontSize: 11\n[GumballMachine|count: int;state: State|insertQuarter();ejectQuarter();turnCrank();setState(s: State);releaseBall()]\n[<abstract>«abstract»;State|+ insertQuarter(gm: GumballMachine);+ ejectQuarter(gm: GumballMachine);+ turnCrank(gm: GumballMachine);+ dispense(gm: GumballMachine)]\n[GumballMachine] o-> [<abstract>«abstract»;State]\n[<abstract>«abstract»;State] --> [GumballMachine]\n[NoQuarterState|<<static>> INSTANCE] -:> [<abstract>«abstract»;State]\n[HasQuarterState|<<static>> INSTANCE] -:> [<abstract>«abstract»;State]\n[SoldState|<<static>> INSTANCE] -:> [<abstract>«abstract»;State]\n[SoldOutState|<<static>> INSTANCE] -:> [<abstract>«abstract»;State]\n```\n\n- Context calls `state.insertQuarter(this)` — only a **dependency** (dashed) back to the Context\n- states are **stateless** → one shared instance each, for **all** machines\n- Context no longer needs a field per state\n\n<style scoped>section { font-size: 20px; }</style>\n"
    },
    {
      "name": "V3-Interface-Cached",
      "x": 720,
      "y": 540,
      "text": "# Variant 3 — interface, Context cached in constructor\n\n```nomnoml\n#direction: down\n#spacing: 30\n#padding: 6\n#fontSize: 11\n[GumballMachine|count: int;state: State;noQuarterState: State;hasQuarterState: State;soldState: State;soldOutState: State|insertQuarter();ejectQuarter();turnCrank();setState(s: State);releaseBall()]\n[<interface>«interface»;State|insertQuarter();ejectQuarter();turnCrank();dispense()]\n[GumballMachine] o-> 4 [<interface>«interface»;State]\n[NoQuarterState|- gm: GumballMachine|+ NoQuarterState(gm)] --:> [<interface>«interface»;State]\n[HasQuarterState|- gm: GumballMachine|+ HasQuarterState(gm)] --:> [<interface>«interface»;State]\n[SoldState|- gm: GumballMachine|+ SoldState(gm)] --:> [<interface>«interface»;State]\n[SoldOutState|- gm: GumballMachine|+ SoldOutState(gm)] --:> [<interface>«interface»;State]\n```\n\n- **the version used in Head First Design Patterns**\n- every concrete state repeats the field + constructor, and implements **every** method\n- `new SoldState(this)` — one set of states **per machine**\n\n<style scoped>section { font-size: 20px; }</style>\n"
    },
    {
      "name": "V4-Interface-Param",
      "x": 960,
      "y": 540,
      "text": "# Variant 4 — interface, Context passed to each event\n\n```nomnoml\n#direction: down\n#spacing: 30\n#padding: 6\n#fontSize: 11\n[GumballMachine|count: int;state: State|insertQuarter();ejectQuarter();turnCrank();setState(s: State);releaseBall()]\n[<interface>«interface»;State|insertQuarter(gm: GumballMachine);ejectQuarter(gm: GumballMachine);turnCrank(gm: GumballMachine);dispense(gm: GumballMachine)]\n[GumballMachine] o-> [<interface>«interface»;State]\n[<interface>«interface»;State] --> [GumballMachine]\n[NoQuarterState] --:> [<interface>«interface»;State]\n[HasQuarterState] --:> [<interface>«interface»;State]\n[SoldState] --:> [<interface>«interface»;State]\n[SoldOutState] --:> [<interface>«interface»;State]\n```\n\n- states hold **no fields at all** — they are pure behaviour\n- can be **shared**: singletons, enum constants or static instances\n- every concrete state still implements **every** method (no superclass defaults)\n\n<style scoped>section { font-size: 20px; }</style>\n"
    },
    {
      "name": "Variants-Compared",
      "x": 1200,
      "y": 540,
      "text": "# The four variants compared\n\n| | Context reference **cached** (constructor) | Context **passed** as event parameter |\n|---|---|---|\n| **Abstract superclass** | **V1** — field + constructor written once; default behaviour inherited; states per machine | **V2** — default behaviour inherited; stateless, **shareable** states |\n| **Interface** | **V3** — *Head First* version; field + constructor repeated in each state; states per machine | **V4** — stateless, **shareable**; every method implemented in every state |\n\n- **Cached**: simpler method signatures — but each Context needs **its own** State objects\n- **Passed**: longer signatures — but states can be **shared** between Contexts\n- **Superclass**: less duplication — but uses up the single inheritance slot (Java / C#)\n\n<style scoped>section { font-size: 22px; }</style>\n"
    },
    {
      "name": "References",
      "x": 0,
      "y": 720,
      "text": "# References\n"
    },
    {
      "name": "Ref-HFDP",
      "x": 240,
      "y": 720,
      "text": "# References\n\n- Freeman, E. & Robson, E. (2020) *Head First Design Patterns*, 2nd edn. O'Reilly — **Chapter 10: The State Pattern**\n- Gamma, E., Helm, R., Johnson, R. & Vlissides, J. (1995) *Design Patterns: Elements of Reusable Object-Oriented Software*. Addison-Wesley — **State**, p. 305\n- Matt Smith — Unity cookbook state pattern\n  <https://github.com/dr-matt-smith/unity-cookbook-2018-ch14-02-state-pattern>\n\n<style scoped>section { font-size: 26px; }</style>\n"
    }
  ]
}
