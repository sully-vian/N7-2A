from functools import wraps

num_indent = 0


def trace(f: callable) -> callable:
    @wraps(f)
    def wrapper(*p, **kw):
        global num_indent
        indent = num_indent * "\t"

        p_str = ', '.join(map(str, p))
        kw_str = kw if kw else ''
        p_kw_str = p_str + kw_str

        print(f"{indent}--> {f.__name__}({p_kw_str})")
        num_indent += 1

        try:
            r = f(*p, **kw)
        except Exception as e:
            r = e

        print(f"{indent}<-- {r}")
        num_indent -= 1
        return r
    return wrapper
