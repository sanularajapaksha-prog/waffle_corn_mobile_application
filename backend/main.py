from fastapi import FastAPI
from typing import List
from .models import WaffleCone, Order

app = FastAPI(title="Waffle Cone API")

mock_waffles = [
    WaffleCone(id=1, name="Classic Vanilla", description="Crispy waffle cone with smooth vanilla ice cream", price=3.5, image_url="https://images.unsplash.com/photo-1558231367-9382f6e91986?q=80&w=300&auto=format&fit=crop"),
    WaffleCone(id=2, name="Double Chocolate", description="Chocolate cone with rich dark chocolate scoops", price=4.5, image_url="https://images.unsplash.com/photo-1572490122747-3968b75bf6f9?q=80&w=300&auto=format&fit=crop"),
    WaffleCone(id=3, name="Strawberry Dream", description="Sweet pink cone with fresh strawberry chunks", price=4.0, image_url="https://images.unsplash.com/photo-1497034825429-c343d7c6a68f?q=80&w=300&auto=format&fit=crop")
]

@app.get("/api/menu", response_model=List[WaffleCone])
def get_menu():
    return mock_waffles

@app.post("/api/orders")
def place_order(order: Order):
    return {"message": "Order placed successfully", "order_details": order.dict()}

@app.get("/")
def read_root():
    return {"message": "Welcome to the Waffle Cone API"}
