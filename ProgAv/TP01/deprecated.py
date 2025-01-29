from functools import wraps


def deprecated(f: callable) -> callable:
    @wraps(f)
    def wrapper(*p, **kw):
        print(f"la fonction {f.__name__} ne devrait plus être utilisée")
        return f(*p, **kw)
    return wrapper
