from pydantic import BaseModel

class WaffleCone(BaseModel):
    id: int
    name: str
    description: str
    price: float
    image_url: str

class Order(BaseModel):
    waffle_id: int
    quantity: int
