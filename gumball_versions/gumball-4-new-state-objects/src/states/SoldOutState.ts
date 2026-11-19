import { State } from "./State.ts";
import { NoQuarterState } from "./NoQuarterState.ts";
import { GumballMachine } from "../GumballMachine.ts";

export class SoldOutState implements State {
    private machine: GumballMachine;

    constructor(machine: GumballMachine) {
        this.machine = machine;
    }

    public insertQuarter(): void {
        console.log("invalid event");

    }

    public ejectQuarter(): void {
        console.log("invalid event");

    }

    public turnCrank(): void {
        console.log("invalid event");

    }
    
    public entry(): void {
        console.log("(no actions for entry event)");
    }

    public refill(): void {
        // increase count by 5
        const currentCount = this.machine.getCount();
        const newCount = currentCount + 5;
        this.machine.setCount(newCount);
        console.log("added 5 gumballs !");
        
        console.log("Changing to NO QUARTER");
        const newState = new NoQuarterState(this.machine);
        this.machine.setState(newState);
    }


    public toString(): string {
        return "SOLD OUT";
    }
}