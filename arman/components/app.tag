<app>
    <a class="btn btn-primary" href="#input" show={list}>Add</a>
    <a class="btn btn-secondary" href="#/" show={input | edit | detail}>Back</a>

    <list />
    <input-form />
    <edit-form />
    <detail />

    <script>
        let self = this
        self.list = true
        self.input = false
        self.edit = false
        self.detail = false

        let r = route.create()
        r('', home)
        r('input', input)
        r('edit/*', edit)
        r('show/*', detail)

        function home() {
            self.list = true
            self.input = false
            self.edit = false
            self.detail = false
            self.update()
        }

        function input() {
            self.list = false
            self.input = true
            self.edit = false
            self.detail = false
            self.update()
        }

        function edit() {
            self.list = false
            self.input = false
            self.edit = true
            self.detail = false
            self.update()
        }

        function detail() {
            self.list = false
            self.input = false
            self.edit = false
            self.detail = true
            self.update()
        }
    </script>
</app>