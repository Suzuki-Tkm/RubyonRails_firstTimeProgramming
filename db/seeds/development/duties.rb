member = Member.find(1)
0.upto(8) do |idx|
  Duty.create(
    author: member,
    role: %w(代表 副代表 会計係 ユニフォーム係 ボール係 合宿係 試合係 入退部係 イベント係)[idx % 9]
  )
end
