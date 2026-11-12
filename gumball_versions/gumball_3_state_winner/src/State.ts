// State - the interface every gumball machine state implements
//
// One method per ACTION. Each concrete state class answers every action in its own way,
// so the "which state am I in?" if-chains from version 1 disappear: the machine just asks
// its current state object to handle the action (it DELEGATES to it).
//
// Each action prints (console.log) what happened, like the book's System.out.println.

export interface State {
  insertQuarter(): void;
  ejectQuarter(): void;
  turnCrank(): void;
  dispense(): void;
  refill(): void;
  toString(): string;
}
