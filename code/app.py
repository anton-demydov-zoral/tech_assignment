import asyncio

import tornado.web


class MainHandler(tornado.web.RequestHandler):
    def get(self):
        self.write(
            "Congratulations, you figured it out! Please send steps you've performed and fixed code to devops@katapult.com"
        )


def make_app():
    return tornado.web.Application(
        [
            (r"/", MainHandler),
        ]
    )


async def main():
    app = make_app()
    app.listen(APP_PORT)
    await asyncio.Event().wait()


if __name__ == "__main__":
    asyncio.run(main())
