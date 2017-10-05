<input-form show={show}>
    <form action="#" class="mt-3">
        <div class="form-group">
            <label class="col-form-label">Title</label>
            <input type="text" id="title" class="form-control" placeholder="Enter title" onkeyup={inputTitle}>
        </div>

        <div class="form-group">
            <label class="col-form-label">Content</label>
            <textarea id="content" class="form-control" rows="4" onkeyup={inputContent}></textarea>
        </div>

        <button type="submit" class="btn btn-primary" onclick={submit}>Submit</button>
    </form>

    <script>
        let self = this
        self.title = ''
        self.content = ''

        let localRoute = route.create()
        localRoute(function () {
            self.show = false
            self.update()
        })
        localRoute('input', function () {
            self.show = true
            self.update()
        })

        inputTitle(e) {
            self.title = e.target.value
        }

        inputContent(e) {
            self.content = e.target.value
        }

        submit() {
            let params = new URLSearchParams()
            params.append('title', self.title)
            params.append('content', self.content)
            axios.post('https://139.59.113.184/public/arman-api/public/articles', params)
            .then(function (response) {
                route('/')
            })
            .catch(function (error) {
                console.log(error);
            });
        }
    </script>
</input-form>