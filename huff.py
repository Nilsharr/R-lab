from collections import Counter
import turtle


class Node:
    def __init__(self, symbol: str, freq: int, left=None, right=None):
        self.symbol = '[space]' if symbol.isspace() else symbol
        self.freq = freq
        self.left = left
        self.right = right
        self.huff = ''


def printNodes(node: Node, val=''):
    newVal = val + str(node.huff)

    if node.left:
        printNodes(node.left, newVal)
    if node.right:
        printNodes(node.right, newVal)
    if(not node.left and not node.right):
        print(f"{node.symbol}: {newVal}")


def createTree(word: str) -> Node:
    nodes = [Node(symbol, freq)
             for symbol, freq in dict(Counter(word)).items()]
    while len(nodes) > 1:
        # sort ascending by freq
        nodes = sorted(nodes, key=lambda x: x.freq)
        # get two smallest nodes
        left = nodes[0]
        right = nodes[1]
        # assign direction
        left.huff, right.huff = '0', '1'
        # create parent node
        newNode = Node('', left.freq + right.freq, left, right)
        # remove 2 smallest nodes
        nodes = nodes[2:]
        nodes.append(newNode)
    return nodes[0]


def drawTree(root: Node):
    def height(root: Node):
        return 1 + max(height(root.left), height(root.right)) if root else -1

    def jumpto(x: int, y: int):
        t.penup()
        t.goto(x, y)
        t.pendown()

    def draw(node: Node, x: int, y: int, dx: int):
        if node:
            t.goto(x, y)
            jumpto(x, y-20)
            t.write(node.freq, align='center', font=('Verdana', 12, 'normal'))
            if node.symbol:
                jumpto(x, y-38)
                t.write(node.symbol, align='center',
                        font=('Verdana', 12, 'normal'))
            draw(node.left, x-dx, y-60, dx/2)
            jumpto(x, y-20)
            draw(node.right, x+dx, y-60, dx/2)
    t = turtle.Turtle()
    t.speed(0)
    turtle.delay(0)
    h = height(root)
    jumpto(0, 30*h)
    draw(root, 0, 30*h, 40*h)
    t.hideturtle()
    turtle.mainloop()


if __name__ == '__main__':
    word = 'A' * 10 + 'E' * 15 + 'I' * 12 + 'S' * 3 + 'T' * 4 + 'P' * 13 + ' '
    word = 'Teleinformatyka'
    print(dict(Counter(word)))
    node = createTree(word)
    printNodes(node)
    drawTree(node)
    # turtle.TurtleScreen._RUNNING = True
