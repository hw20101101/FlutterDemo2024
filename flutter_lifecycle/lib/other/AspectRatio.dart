class AspectRatioExample extends StatelessWidget {
  const AspectRatioExample({super.key});

  @override
  Widget build(BuildContext context) {
    //使用列表避免 第三个 AspectRatio 的高度溢出的问题
    return ListView(
      children: [
        AspectRatio(
          aspectRatio: 16 / 9,
          child: Container(
            color: Colors.red,
          ),
        ),
        AspectRatio(
          aspectRatio: 16 / 9,
          child: Container(
            color: Colors.blue,
          ),
        ),
        AspectRatio(
          aspectRatio: 16 / 9,
          child: Container(
            color: Colors.orange,
          ),
        ),
      ],
    );
    /*
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 16 / 9,
          child: Container(
            color: Colors.red,
          ),
        ),
        AspectRatio(
          aspectRatio: 16 / 9,
          child: Container(
            color: Colors.blue,
          ),
        ),
        const Expanded(
          child: Icon(
            Icons.ad_units,
            color: Colors.red,
          ),
        )
        // const AspectRatio( //mark 宽度溢出
        //     aspectRatio: 16 / 9, child: Expanded(child: Icon(Icons.ad_units)))
      ],
    ); */
  }
}
