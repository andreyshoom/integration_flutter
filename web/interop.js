class EventEmitter{
    constructor(){
        this._storage = new Map();
    }

    addEventListener(type, handler){
        if (this._storage.has(type)) {
            this._storage.get(type).push(handler);
        }
        else{
            this._storage.set(type,[handler]);
        }
    }

    removeEventListener(type, handler){
        if (this._storage.has(type)) {
            this._storage.set(type,this._storage.get(type).filter((fn)=>fn!=handler));
        }
        return false;
    }

    dispatchEvent(event){
        if (this._storage.has(event.type)) {
            this._storage.get(event.type).forEach(handler => handler(event));
            return true;
        }
        return false;
    }
}

class JsInteropManager extends EventEmitter{
    constructor(){
        super();
    
        this.containerElement = document.createElement('div');

        this.inputElement = document.createElement('input');
        this.inputElement.type = 'text';
        this.containerElement.appendChild(this.inputElement);

        this.buttonElement = document.createElement('button');
        this.buttonElement.innerText = 'Web Native Button';
        this.containerElement.appendChild(this.buttonElement);

        this.buttonElement.addEventListener('click', (e)=>{
            const interopEvent = new JsInteropEvent(this.inputElement.value);
            this.dispatchEvent(interopEvent);
        });
        window._clickManger = this;
    }

}

class JsInteropEvent{
    constructor(value){
        this.type = 'InteropEvent';
        this.value = value;
    }
}

window.ClicksNamespace = {
    JsInteropManager,
    JsInteropEvent,
}