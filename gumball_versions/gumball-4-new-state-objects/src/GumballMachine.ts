import { State } from "./states/State.ts";
import { NoQuarterState } from "./states/NoQuarterState.ts";
import { SoldOutState } from "./states/SoldOutState.ts";

export class GumballMachine {
    private state: State;
    private count: number;

    constructor(count: number){
        this.count = count;

        if(this.count > 0){
            this.state = new NoQuarterState(this);
        } else {
            this.state =  new SoldOutState(this);
        }
    }

    public getCount(): number {
        return this.count;
    }

    public setCount(count: number): void {
        this.count = count;
    }

    public setState(state: State) {
        this.state = state;
        this.state.entry();
    }

    public getState(): State {
        return this.state;
    }

    // deleget the EVENTS
    public refill(): void {
        this.state.refill();
    }

    public insertQuarter(): void {
        this.state.insertQuarter();
    }

    public ejectQuarter(): void {
        this.state.ejectQuarter();
    }

    public turnCrank(): void {
        this.state.turnCrank();
    }

    public entry(): void {
        this.state.entry();
    }

}